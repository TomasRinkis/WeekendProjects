#include "TBG_Grid.h"
#include "TBG_Camera.h"

//<QT
#include<QPoint>
#include<QSize>

//<std & stl
#include<vector>
#include<sstream>

//<small utils
QPoint pointFrom(const QVector3D &vector)
{
    QPoint point(vector.x(), vector.y());
    return point;
}
QVector3D vectorFromRectCenter(const QRect &rect)
{
    const QPoint center = rect.center();
    return QVector3D(center.x(), center.y(), 0);
}

/***********************************************************
* CGridCell
***********************************************************/
//<constructor & destructor
CGridCell::CGridCell()
    : m_iRow(-1)
    , m_iCol(-1)
    , m_vWorldPos(0.0f, 0.0f, 0.0f)
    , m_pGridObject(NULL)
{
    setBBox(CGridCell::getDefaultBBox());
}

CGridCell::~CGridCell()
{
}

//<initers
void CGridCell::init(const int &row, const int &col)
{
    setRow(row);
    setCol(col);
}

//<properties
void CGridCell::setRow(const int &row)
{
    m_iRow = row;

    //<set pos
    const int height = getBBox().height();
    m_vWorldPos.setY(row * height);

    refreshBBox();
}

void CGridCell::setCol(const int &col)
{
    m_iCol = col;

    //<set pos
    const int width = getBBox().width();
    m_vWorldPos.setX(col * width);

    refreshBBox();
}

void CGridCell::refreshBBox()
{
    QPoint bboxPos = pointFrom(m_vWorldPos);
    m_BBox.setX(bboxPos.x());
    m_BBox.setY(bboxPos.y());
}

int CGridCell::getCol() const
{
    return m_iCol;
}

int CGridCell::getRow() const
{
    return m_iRow;
}

void CGridCell::setGridObject(CGridObject * const pObject)
{
    m_pGridObject = pObject;
}

CGridObject * CGridCell::getGridObject() const
{
    return m_pGridObject;
}

void CGridCell::setBBox(const QRect &bbox)
{
    m_BBox = bbox;
}

QRect CGridCell::getBBox() const
{
    return m_BBox;
}

QRect CGridCell::getDefaultBBox()
{
    return QRect(QPoint(0.0f, 0.0f), QSize(40.0f, 40.0f));
}

void CGridCell::setPos(const QVector3D &pos)
{
    m_vWorldPos = pos;
    refreshBBox();
}

QVector3D CGridCell::getPos() const
{
    return m_vWorldPos;
}

/***********************************************************
* CGridObject
***********************************************************/
//<constructor & destructor
CGridObject::CGridObject()
{

}

CGridObject::~CGridObject()
{

}


/***********************************************************
* CGrass
***********************************************************/
//Constructor & Destructor
CGrass::CGrass()
{

}

CGrass::~CGrass()
{

}


/***********************************************************
* CBuilding
***********************************************************/
//Constructor & Destructor
CBuilding::CBuilding()
{

}

CBuilding::~CBuilding()
{

}


//<Grid as C-style for fun :)
/***********************************************************
* Grid
***********************************************************/
namespace GridAPI
{
typedef std::vector< std::vector<CGridCell*> > TGrid2DArray;

namespace //<state, prefer struct, but too lazy :(
{
const uint c_grid_witdh  =   30;
const uint c_grid_heigth =   30;

TGrid2DArray m_Grid2DArray;
}

void Create()
{
    for(uint row = 0; row < c_grid_heigth; ++row)
    {
        std::vector<CGridCell*> gridRow;

        for(uint col = 0; col < c_grid_witdh; ++col)
        {
            CGridCell *pCell = new CGridCell;
            pCell->init(row, col);

            gridRow.push_back(pCell);
        }

        m_Grid2DArray.push_back(gridRow);
    }
}


void Destroy()
{
#define SAFE_DELETE(p) if(p) delete p; p = NULL;

    for(uint row = 0; row < c_grid_heigth; ++row)
    {
        for(uint col = 0; col < c_grid_witdh; ++col)
        {
            SAFE_DELETE(m_Grid2DArray[row][col]);

        }

        m_Grid2DArray[row].clear();
    }
}


int randomInRange(const int &min, const int &max)
{
    return  int( random() / (RAND_MAX + 1.0) * (max + 1 - min) + min );
}


QColor randomColor()
{
    return QColor(randomInRange(50, 255), randomInRange(50, 255), randomInRange(50, 255));
}


const int hireMeBitMap[c_grid_heigth][c_grid_witdh] =
{
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 0},
    {0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 0},
    {0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 1, 1, 1, 0, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 1, 1, 0, 1, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
};

void Render(QPainter &painter)
{
    for(uint row = 0; row < c_grid_heigth; ++row)
    {
        for(uint col = 0; col < c_grid_witdh; ++col)
        {
            CGridCell *pCell = m_Grid2DArray[row][col];

            const QVector3D worldPos  = pCell->getPos();//vectorFromRectCenter(bbox);
            const QVector3D screenPos = CameraAPI::toScreen(worldPos);

            const QPoint rectCenter = pointFrom(screenPos);
            const QSize rectSize(20, 20);

            QRect bbox(rectCenter, rectSize);

            if(hireMeBitMap[row][col] == 1)
            {
               painter.fillRect(bbox, QColor());
            }
            else
            {
                painter.drawRect(bbox);
            }
        }
    }
}

}
