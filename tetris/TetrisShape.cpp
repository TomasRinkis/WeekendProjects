#include "TetrisShape.h"

//std & stl
#include<numeric>
#include<iostream>

/***********************************************************
* CGridTile
***********************************************************/
//<constructor & destructor
CGridTile::CGridTile()
    :r(-1)
    ,c(-1)
    ,color(1, 1, 1)
    ,empty(true)
{

}

CGridTile::~CGridTile()
{

}

//<initers
void CGridTile::init(const int &row, const int col)
{
    setRow(row);
    setCol(col);
}

CGridTile *CGridTile::clone()
{
    CGridTile *pNewTile = new CGridTile();

    pNewTile->setCol(getCol());
    pNewTile->setRow(getRow());
    pNewTile->setColor(getColor());
    pNewTile->setEmpty(isEmpty());

    return pNewTile;
}

//<properties
int CGridTile::getRow() const
{
    return r;
}

void CGridTile::setRow(const int &row)
{
    r = row;
}

int CGridTile::getCol() const
{
    return c;
}

void CGridTile::setCol(const int &col)
{
    c = col;
}

QColor CGridTile::getColor() const
{
    return color;
}

void CGridTile::setColor(const QColor &color)
{
    this->color = color;
}

QRect CGridTile::getBBoxAt(const int &r, const int &c)
{
    QSize size = CGridTile::getDimension();
    QPoint point(c * size.width(), r * size.height());

    return QRect(point, size);
}

QRect CGridTile::getBBox() const
{
    return CGridTile::getBBoxAt(r, c);
}

bool CGridTile::isEmpty() const
{
    return empty;
}

void CGridTile::setEmpty(const bool &empty)
{
    this->empty = empty;
}

QSize CGridTile::getDimension()
{
    return QSize(20, 20);
}

//<small factory
CGridTile *CGridTile::createEmptyAt(const int &row, const int col)
{
    CGridTile *pGridTile = new CGridTile();
    pGridTile->init(row, col);
    return pGridTile;
}

CGridTile *CGridTile::createAt(const int &row, const int &col, const QColor &color)
{
    CGridTile *pGridTile = CGridTile::createEmptyAt(row, col);
    pGridTile->setColor(color);
    pGridTile->setEmpty(false);

    return pGridTile;
}


/***********************************************************
* CTetrisShape
* Container of grid tiles
***********************************************************/
//<constructor & destructor
CTetrisShape::CTetrisShape()
    : r(0)
    , c(0)

{
}

CTetrisShape::~CTetrisShape()
{
}

void CTetrisShape::init(const int &row, const int &col, const TGridTileArray &gridTileArray)
{
    r = row;
    c = col;
    m_GridTileArray = gridTileArray;
}

CTetrisShape *CTetrisShape::clone()
{
    CTetrisShape *pNewShape = new CTetrisShape();

    pNewShape->setCol(getCol());
    pNewShape->setRow(getRow());

    CTetrisShape::TGridTileArray gridTileArray = getGridTileArray();
    CTetrisShape::TGridTileArray newGridTileArray;

    for(size_t i = 0; i < gridTileArray.size(); ++i)
    {
        CGridTile *pTile  = gridTileArray[i];
        CGridTile *pTileClone = pTile->clone();

        newGridTileArray.push_back(pTileClone);
    }

    pNewShape->setGridTileArray(newGridTileArray);

    return pNewShape;
}


//<properties

void CTetrisShape::setRow(const int &row)
{
    r = row;
}

int CTetrisShape::getRow() const
{
    return r;
}

void CTetrisShape::setCol(const int &col)
{
    c = col;
}

int CTetrisShape::getCol() const
{
    return c;
}

void CTetrisShape::changeCol(const int &num)
{
    c += num;
}

void CTetrisShape::changeRow(const int &num)
{
    r += num;
}

CTetrisShape::TIterator CTetrisShape::begin()
{
    return  m_GridTileArray.begin();
}

CTetrisShape::TIterator CTetrisShape::end()
{
   return m_GridTileArray.end();
}

int CTetrisShape::getTopRow()
{
    int leftRow = std::numeric_limits<int>::max();

    for(TIterator it = begin(); it != end(); ++it)
    {
        const int TileRow = (*it)->getRow();

        if(TileRow < leftRow)
        {
            leftRow = TileRow;
        }
    }

    return leftRow + r;
}

int CTetrisShape::getBotRow()
{
    int rightRow = std::numeric_limits<int>::min();

    for(TIterator it = begin(); it != end(); ++it)
    {
        const int TileRow = (*it)->getRow();

        if(TileRow > rightRow)
        {
            rightRow = TileRow;
        }
    }

    return rightRow + r;
}

int CTetrisShape::getLeftCol()
{
    int topCol = std::numeric_limits<int>::max();

    for(TIterator it = begin(); it != end(); ++it)
    {
        const int TileCol = (*it)->getCol();

        if(topCol > TileCol)
        {
            topCol = TileCol;
        }
    }

    return topCol + c;
}

int CTetrisShape::getRightCol()
{
    int botCol = std::numeric_limits<int>::min();

    for(TIterator it = begin(); it != end(); ++it)
    {
        const int TileCol = (*it)->getCol();

        if(botCol < TileCol)
        {
            botCol = TileCol;
        }
    }

    return botCol + c;
}

CTetrisShape::TGridTileArray CTetrisShape::getGridTileArray() const
{
    return m_GridTileArray;
}

void CTetrisShape::setGridTileArray(const TGridTileArray &gridTileArray)
{
    m_GridTileArray = gridTileArray;
}

void CTetrisShape::rotate()
{
    for(TIterator it = begin(); it != end(); ++it)
    {
        const int row = (*it)->getRow();
        const int col = (*it)->getCol();

        (*it)->setRow(col);
        (*it)->setCol(row);
    }
}

void CTetrisShape::dump()
{
    const int t = getTopRow();
    const int b = getBotRow();
    const int l = getLeftCol();
    const int r = getRightCol();

    std::cout<<"top: "<<t<<" bot:"<<b<<" left:"<<l<<" rigth:"<<r<<std::endl;
}

//<small util
int randomInRange(const int &min, const int &max)
{
    return  int( random() / (RAND_MAX + 1.0) * (max + 1 - min) + min );
}

CTetrisShape::EShapeType randomInRange(const CTetrisShape::EShapeType &min, const CTetrisShape::EShapeType &max)
{
    return  (CTetrisShape::EShapeType)randomInRange((uint)min, (uint)max);
}

//<factory
// I know, I know, could be done in better way
CTetrisShape *CTetrisShape::createRandom()
{
    //<colorArray
    static QColor ColorArray[] = {QColor(255, 0, 0), QColor(0, 255, 0), QColor(0, 0, 255)};

    //grid pos Array
    static QPoint PointArray[] = {QPoint(2, 0), QPoint(3, 0), QPoint(5, 0), QPoint(8, 0)};

    //Shapes
    static QPoint ShapePartPosArray[4][4] =
    {
        {QPoint(0, 0), QPoint(1, 0), QPoint(2, 0), QPoint(3, 0)},//<Line4ShapeFlag
        {QPoint(0, 0), QPoint(1, 0), QPoint(0, 0), QPoint(0, 0)},//Line2ShapeFlag
        {QPoint(0, 1), QPoint(0, 0), QPoint(1, 1), QPoint(1, 0)},//CubeShapeFlag
        {QPoint(0, 1), QPoint(1, 1), QPoint(1, 0), QPoint(2, 0)}//ZShapeFlag
    };

    //<random
    const QColor randColor = ColorArray[randomInRange(0, 2)];
    const QPoint randPos  = PointArray[randomInRange(0, 3)];
    const EShapeType randShape = randomInRange(Line4ShapeFlag, ZShapeFlag);

    TGridTileArray gridTileArray;
    for(int i = 0; i < 4; ++i)
    {
        QPoint gridPos = ShapePartPosArray[randShape][i];
        CGridTile *pGridTile = CGridTile::createAt(gridPos.y(), gridPos.x(), randColor);
        gridTileArray.push_back(pGridTile);
    }

    CTetrisShape *pShape = new CTetrisShape();
    pShape->init(randPos.y(), randPos.x(), gridTileArray);

    return pShape;
}
