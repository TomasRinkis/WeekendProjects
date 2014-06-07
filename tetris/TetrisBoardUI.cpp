#include "TetrisBoardUI.h"
#include"TetrisShape.h"

//<QT
#include<QBasicTimer>
#include<QTimerEvent>
#include<QPaintEvent>

//<std & stl
#include <iostream>

namespace
{
static int c_grid_width    = 14;//15
static int c_grid_height   = 19;//19
}

//<small factory
QBasicTimer *createBasicTimer()
{
    QBasicTimer *pBasicTimer = new QBasicTimer();

    return pBasicTimer;
}

//<Constructor & Destructor
CTetrisBoardUI::CTetrisBoardUI()
    : m_pCurrentShape(NULL)
{
    setFrameStyle(QFrame::Panel | QFrame::Sunken);

    //<create instances
    m_pUpdateTimer = createBasicTimer();
    m_pUpdateTimer->start(300, this);
}

CTetrisBoardUI::~CTetrisBoardUI()
{
}

void CTetrisBoardUI::initGrid()
{
    for(int r = 0; r < c_grid_height; ++r)
    {
        std::vector<CGridTile*> row;

        for(int c = 0; c < c_grid_width; ++c)
        {
            CGridTile *pGridTile = CGridTile::createEmptyAt(r, c);
            row.push_back(pGridTile);
        }

        m_Grid.push_back(row);
    }
}

CTetrisBoardUI *CTetrisBoardUI::create()
{
    CTetrisBoardUI *pTetrisBoardUI = new CTetrisBoardUI();
    pTetrisBoardUI->initGrid();

    return pTetrisBoardUI;
}


void CTetrisBoardUI::timerEvent(QTimerEvent *event)
{

    if (event->timerId() == m_pUpdateTimer->timerId())
    {
        update();
        repaint();
    }

    QFrame::timerEvent(event);
}

void CTetrisBoardUI::renderGridTiles(QPainter &painter)
{
    for(int r = 0; r < c_grid_height; ++r)
    {
        for(int c = 0; c < c_grid_width; ++c)
        {
            CGridTile *pTile = m_Grid[r][c];

            if(!pTile->isEmpty())
            {
                const QRect rect = CGridTile::getBBoxAt(r, c);
                painter.fillRect(rect, pTile->getColor());
            }
        }
    }
}

void CTetrisBoardUI::renderGridLines(QPainter &painter)
{
    for(int r = 0; r < c_grid_height; ++r)
    {
        for(int c = 0; c < c_grid_width; ++c)
        {
            const QRect rect = CGridTile::getBBoxAt(r, c);
            painter.drawRect(rect);
        }
    }
}

void CTetrisBoardUI::renderCurrentShape(QPainter &painter)
{
    if(m_pCurrentShape)
    {
        CTetrisShape::TGridTileArray gridTileArray = m_pCurrentShape->getGridTileArray();

        const int shapeRow = m_pCurrentShape->getRow();
        const int shapeCol = m_pCurrentShape->getCol();

        for(size_t i = 0; i < gridTileArray.size(); ++i)
        {
            CGridTile *pTile = gridTileArray[i];

            const int TileRow   = pTile->getRow();
            const int TileCol   = pTile->getCol();
            const QColor TileColor = pTile->getColor();

            const int row = shapeRow + TileRow;
            const int col = shapeCol + TileCol;

            const QRect TileRect = CGridTile::getBBoxAt(row, col);

            painter.fillRect(TileRect, TileColor);
        }
    }
}

void CTetrisBoardUI::paintEvent(QPaintEvent *event)
{
    QPainter painter;
    painter.begin(this);

    //<render current shape
    renderCurrentShape(painter);

    //<render grid Tiles
    renderGridTiles(painter);

    //<render grid lines
    renderGridLines(painter);

    painter.end();

    QFrame::paintEvent(event);
}

void CTetrisBoardUI::update()
{
    if(!m_pCurrentShape)
    {
        m_pCurrentShape = CTetrisShape::createRandom();
    }

    if(canMoveShapeDown())
    {
        moveShapeDown();
    }
    else
    {
        fillGridWithTiles();
        removeLines();
    }
}

void CTetrisBoardUI::removeLines()
{
    int numLinesRemoved = 0;

    for(int r = 0; r < c_grid_height; ++r)
    {
        bool bRemoveRow = true;

        for(int c = 0; c < c_grid_width; ++c)
        {
            if(m_Grid[r][c]->isEmpty() && bRemoveRow)
            {
                bRemoveRow = false;
            }
        }

        if(bRemoveRow)
        {
            removeLine(r);
            ++numLinesRemoved;
        }
    }

    emit triggerLinesRemovedChange(numLinesRemoved);
}

void CTetrisBoardUI::removeLine(const int &line)
{
    for(int c = 0; c < c_grid_width; ++c)
    {
        m_Grid[line][c]->setEmpty(true);
        m_Grid[line][c]->setColor(QColor());
    }

    //<move down all other shapes

    for(int r = line; r > 0; --r)
    {
        for(int c = 0; c < c_grid_width; ++c)
        {
            if(!m_Grid[r][c]->isEmpty())
            {
                m_Grid[r][c]->setEmpty(true);
                m_Grid[r+1][c]->setEmpty(false);
                m_Grid[r+1][c]->setColor(m_Grid[r][c]->getColor());
            }
        }
    }

}

void  CTetrisBoardUI::fillGridWithTiles()
{
    if(m_pCurrentShape)
    {
        CTetrisShape::TGridTileArray gridTileArray = m_pCurrentShape->getGridTileArray();

        const int shapeRow = m_pCurrentShape->getRow();
        const int shapeCol = m_pCurrentShape->getCol();

        for(size_t i = 0; i < gridTileArray.size(); ++i)
        {
            CGridTile *pTile = gridTileArray[i];

            const int TileRow = pTile->getRow();
            const int TileCol = pTile->getCol();

            const int row = shapeRow + TileRow;
            const int col = shapeCol + TileCol;

            m_Grid[row][col]->setEmpty(false);
            m_Grid[row][col]->setColor(pTile->getColor());
        }

        delete m_pCurrentShape;
        m_pCurrentShape= NULL;
    }
}

bool CTetrisBoardUI::collidesWithGridTile(CTetrisShape *pShape)
{
    if(pShape)
    {
        const int shapeCol = pShape->getCol();
        const int shapeRow = pShape->getRow();

        CTetrisShape::TGridTileArray gridTileArray = pShape->getGridTileArray();

        for(size_t i = 0; i < gridTileArray.size(); ++i)
        {
            CGridTile *pTile = gridTileArray[i];

            const int TileRow = pTile->getRow();
            const int TileCol = pTile->getCol();

            const int row = shapeRow + TileRow;
            const int col = shapeCol + TileCol;

            if(!m_Grid[row][col]->isEmpty())
            {
                return true;
            }
        }
    }

    return false;
}

bool CTetrisBoardUI::canMoveShapeDown()
{
    if(m_pCurrentShape)
    {
        CTetrisShape *pNextShape = m_pCurrentShape->clone();
        pNextShape->changeRow(1);

        const int botRow = pNextShape->getBotRow();
        const bool bInsideGrid = botRow  < c_grid_height;
        bool bCollides = bInsideGrid && collidesWithGridTile(pNextShape);

        delete pNextShape;
        pNextShape = NULL;

        return !bCollides && bInsideGrid;
    }
    return false;
}

bool CTetrisBoardUI::canMoveShapeLeft()
{
    if(m_pCurrentShape)
    {
        CTetrisShape *pNextShape = m_pCurrentShape->clone();
        pNextShape->changeCol(-1);

        const int leftCol = pNextShape->getLeftCol();
        const bool bInsideGrid = leftCol  >= 0;
        bool bCollides = bInsideGrid && collidesWithGridTile(pNextShape);

        delete pNextShape;
        pNextShape = NULL;

        return !bCollides && bInsideGrid;
    }
    return false;
}


bool CTetrisBoardUI::canMoveShapeRigth()
{
    if(m_pCurrentShape)
    {
        CTetrisShape *pNextShape = m_pCurrentShape->clone();
        pNextShape->changeCol(1);

        const int rightCol = pNextShape->getRightCol();
        const bool bInsideGrid = rightCol  < c_grid_width;
        bool bCollides = bInsideGrid && collidesWithGridTile(pNextShape);

        delete pNextShape;
        pNextShape = NULL;

        return !bCollides && bInsideGrid;
    }
    return false;
}

bool CTetrisBoardUI::canRotateShape()
{
    if(m_pCurrentShape)
    {
        CTetrisShape *pNextShape = m_pCurrentShape->clone();
        pNextShape->rotate();

        bool bCollides = collidesWithGridTile(pNextShape);

        delete pNextShape;
        pNextShape = NULL;

        return !bCollides;
    }
    return false;
}


void CTetrisBoardUI::moveShapeDown()
{
    if(m_pCurrentShape)
    {
        m_pCurrentShape->changeRow(1);
    }
}

void CTetrisBoardUI::handleMoveLeftSignal()
{
    if(m_pCurrentShape && canMoveShapeLeft())
    {
        const int leftCol = m_pCurrentShape->getLeftCol();

        if(leftCol > 0)
        {
            m_pCurrentShape->changeCol(-1);
        }
    }
}

void CTetrisBoardUI::handleMoveRightSignal()
{
    if(m_pCurrentShape && canMoveShapeRigth())
    {
        const int rightCol = m_pCurrentShape->getRightCol();

        if(rightCol < c_grid_width - 1)
        {
            m_pCurrentShape->changeCol(1);
        }
    }
}

void CTetrisBoardUI::handleRotateSignal()
{
    if(m_pCurrentShape && canRotateShape())
    {
        m_pCurrentShape->rotate();
    }
}
