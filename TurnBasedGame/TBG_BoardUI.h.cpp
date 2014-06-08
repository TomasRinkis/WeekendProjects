#include "TBG_BoardUI.h"
#include "TBG_Grid.h"
#include "TBG_Camera.h"

//<QT
#include<QBasicTimer>
#include<QTimerEvent>
#include<QPaintEvent>

//<std & stl
#include <iostream>

//<small factory
QBasicTimer *createBasicTimer()
{
    QBasicTimer *pBasicTimer = new QBasicTimer();

    return pBasicTimer;
}

//<Constructor & Destructor
CBoardUI::CBoardUI()
{
    setFrameStyle(QFrame::Panel | QFrame::Sunken);

    //<create instances
    m_pUpdateTimer = createBasicTimer();
    m_pUpdateTimer->start(300, this);

    GridAPI::Create();
}

CBoardUI::~CBoardUI()
{
    GridAPI::Destroy();
}


void CBoardUI::timerEvent(QTimerEvent *event)
{

    if (event->timerId() == m_pUpdateTimer->timerId())
    {
        repaint();
    }

    QFrame::timerEvent(event);
}


void CBoardUI::paintEvent(QPaintEvent *event)
{
    QPainter painter;
    painter.begin(this);

    {//<render
        GridAPI::Render(painter);
    }

    painter.end();

    QFrame::paintEvent(event);
}

void CBoardUI::mouseMoveEvent(QMouseEvent *event)
{
    std::cout<<"------------------------------------"<<std::endl;

    const int screen_x = event->x();
    const int screen_y = event->y();
    CameraAPI::moveTo(screen_x, screen_y);

    std::cout<<"screen: x:"<<screen_x<<" y:"<<screen_y<<std::endl;

    const QVector3D world = CameraAPI::toWorld(QVector3D(screen_x, screen_y, 0));
    std::cout<<"world: x:"<<world.x()<<" y:"<<world.y()<<std::endl;
    std::cout<<"------------------------------------"<<std::endl;

    QFrame::mousePressEvent(event);
}

void CBoardUI::mousePressEvent(QMouseEvent *event)
{
    QFrame::mousePressEvent(event);
}

