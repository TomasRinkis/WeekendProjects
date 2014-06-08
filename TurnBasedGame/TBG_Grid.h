#ifndef TBG_GRID_H
#define TBG_GRID_H

//<QT
#include<QRect>
#include<QVector3D>
#include<QPainter>

//<fowards
class CGridObject;


//<Avoid protected!

/***********************************************************
* CGridCell
***********************************************************/
class CGridCell
{
public:
    //<constructor & destructor
    CGridCell();
    virtual ~CGridCell();

    //<initers
    void init(const int &row, const int &col);

    //<properties
    void setRow(const int &row);
    void setCol(const int &col);

    int getCol() const;
    int getRow() const;

    void setGridObject(CGridObject * const pObject);
    CGridObject * getGridObject() const;

    void setBBox(const QRect &bbox);
    QRect getBBox() const;

    void setPos(const QVector3D &pos);
    QVector3D getPos() const;

    static QRect getDefaultBBox();
private:
    void refreshBBox();
private:
    int m_iRow;
    int m_iCol;
    QRect m_BBox;
    QVector3D m_vWorldPos;

    CGridObject *m_pGridObject;
};

/***********************************************************
* CGridObject
***********************************************************/
class CGridObject
{
public:
    //<constructor & destructor
    CGridObject();
    virtual ~CGridObject();
};

/***********************************************************
* CGrass
***********************************************************/
class CGrass : public CGridObject
{
    //Constructor & Destructor
    CGrass();
    ~CGrass();
};

/***********************************************************
* CBuilding
***********************************************************/
class CBuilding : public CGridObject
{
    //Constructor & Destructor
    CBuilding();
    ~CBuilding();
};

//<Building manager if nedded
//<Grass manager if needed
//<bla bla manager if needed



//<Grid as C-style for fun :)
/***********************************************************
* Grid
***********************************************************/
namespace GridAPI
{
    void Create();
    void Destroy();

    void Render(QPainter &painter);
}

#endif // TBG_GRID_H
