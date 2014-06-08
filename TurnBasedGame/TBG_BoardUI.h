#ifndef TBG_BOARDUI_H
#define TBG_BOARDUI_H

//<QT
#include<QFrame>
#include<QPainter>

//<fowards
class QBasicTimer;
class QPaintEvent;
class QTimerEvent;
class QMouseEvent;

class CBoardUI : public QFrame
{
private:
    Q_OBJECT
public:
    //<Constructor & Destructor
    CBoardUI();
    ~CBoardUI();

protected:
    void paintEvent(QPaintEvent *event);
    void timerEvent(QTimerEvent *event);

    void mousePressEvent(QMouseEvent *event);
    void mouseMoveEvent(QMouseEvent *event);

private:    //<state
    QBasicTimer *m_pUpdateTimer;
};

#endif // TBG_BOARDUI_H
