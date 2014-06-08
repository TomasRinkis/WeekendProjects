#include "TBG_Camera.h"

//QT
#include<QMatrix4x4>

namespace CameraAPI
{

struct SState
{
    //<constructor & destructor
    SState()
    {
        m_ViewMatrix.setToIdentity();
    }

    ~SState()
    {
    }

public:
    QMatrix4x4 viewMatrix() const
    {
        return m_ViewMatrix;
    }

    QMatrix4x4 invertedMatrix() const
    {
        return m_ViewMatrix.inverted();
    }

    void moveViewTo(const QVector3D & pos)
    {
        m_ViewMatrix.setToIdentity();
        //<scale if need
        //<rotate if need
        m_ViewMatrix.translate(pos);
    }

private:
    QMatrix4x4 m_ViewMatrix;

} m_sState;


QVector3D toWorld(const QVector3D &pos)
{
    return m_sState.viewMatrix() * pos;
}

QVector3D toScreen(const QVector3D &pos)
{
    return m_sState.invertedMatrix() * pos;
}


void moveTo(const QVector3D &pos)
{
    m_sState.moveViewTo(pos);
}

void moveTo(const int &x, const int &y)
{
    moveTo(QVector3D(x, y, 0));
}

}
