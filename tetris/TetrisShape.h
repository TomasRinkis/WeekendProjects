#ifndef TETRISSHAPE_H
#define TETRISSHAPE_H

//<QT
#include<QColor>
#include<QSize>
#include<QPoint>
#include<QRect>

//<std & stl
#include<vector>

/***********************************************************
* CGridTile
***********************************************************/
class CGridTile
{
public:
    //<constructor & destructor
    CGridTile();
    ~CGridTile();

    CGridTile *clone();

    //<initers
    void init(const int &row, const int col);

    //<properties
    int getRow() const;
    void setRow(const int &row);

    int getCol() const;
    void setCol(const int &col);

    QColor getColor() const;
    void setColor(const QColor &color);

    static QRect getBBoxAt(const int &r, const int &c);
    QRect getBBox() const;

    bool isEmpty() const;
    void setEmpty(const bool &empty);

    static QSize getDimension();

    //<small factory
    static CGridTile *createEmptyAt(const int &row, const int col);
    static CGridTile *createAt(const int &row, const int &col, const QColor &color);

private: //state
    int r, c;
    QColor color;
    bool empty;
};

/***********************************************************
* CTetrisShape
* Container of grid tiles
***********************************************************/
class CTetrisShape
{
public:
    enum EShapeType
    {
        Line4ShapeFlag,
        Line2ShapeFlag,
        CubeShapeFlag,
        ZShapeFlag
    };

    typedef std::vector<CGridTile*> TGridTileArray;
    typedef TGridTileArray::iterator TIterator;
public:

    //<Constructor & Destructor
    CTetrisShape();
    ~CTetrisShape();

    void init(const int &row, const int &col, const TGridTileArray &gridTileArray);
    CTetrisShape *clone();

public://<properties
    void setRow(const int &row);
    int getRow() const;

    void setCol(const int &col);
    int getCol() const;

    void changeCol(const int &num);
    void changeRow(const int &num);

    int getBotRow();
    int getTopRow();

    int getLeftCol();
    int getRightCol();

    TGridTileArray getGridTileArray() const;
    void setGridTileArray(const TGridTileArray &gridTileArray);
    void dump();
    void rotate();

    TIterator begin();
    TIterator end();

private://<state

    int r, c;
    TGridTileArray m_GridTileArray;
public:
    static CTetrisShape *createRandom();
};

#endif // TETRISSHAPE_H
