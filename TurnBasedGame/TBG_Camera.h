#ifndef TBG_CAMERA_H
#define TBG_CAMERA_H

#include<QVector3D>

//prefer design in C-style
namespace CameraAPI
{
    QVector3D toWorld(const QVector3D &pos);
    QVector3D toScreen(const QVector3D &pos);

    void moveTo(const QVector3D &pos);
    void moveTo(const int &x, const int &y);
}

#endif
