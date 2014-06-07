#ifndef TETRISBOARDUI_H
#define TETRISBOARDUI_H

//<QT
#include<QFrame>
#include<QPainter>

//<fowards
class QBasicTimer;
class QPaintEvent;
class QTimerEvent;
class CTetrisShape;
class CGridTile;

class CTetrisBoardUI : public QFrame
{
public:
    typedef std::vector< std::vector<CGridTile*> > TGrid;

private:
    Q_OBJECT
public:
    //<Constructor & Destructor
    CTetrisBoardUI();
    ~CTetrisBoardUI();

    static CTetrisBoardUI *create();

    //< Nice feature, signals - slots
public slots:
    void handleMoveLeftSignal();
    void handleMoveRightSignal();
    void handleRotateSignal();

signals:
    void triggerLinesRemovedChange(int lines);

protected:
    void paintEvent(QPaintEvent *event);
    void timerEvent(QTimerEvent *event);

private:
    void update();

    bool canMoveShapeDown();
    bool canMoveShapeLeft();
    bool canMoveShapeRigth();
    bool canRotateShape();
    bool collidesWithGridTile(CTetrisShape *pShape);

    void fillGridWithTiles();
    void removeLines();
    void removeLine(const int &line);
    void moveShapeDown();

    void initGrid();
    void renderGridLines(QPainter &painter);
    void renderCurrentShape(QPainter &painter);
    void renderGridTiles(QPainter &painter);
private:    //<state
    QBasicTimer *m_pUpdateTimer;
    TGrid m_Grid;

    CTetrisShape *m_pCurrentShape;
};

#endif // TETRISBOARDUI_H
