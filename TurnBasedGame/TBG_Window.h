#ifndef TETRISUI_H
#define TETRISUI_H

#include<QWidget>

//<Fowards
class CBoardUI;

class CWindow : public QWidget
{
    Q_OBJECT
public:

    //<Constructor & Destructor
    CWindow();
    ~CWindow();

private://<state
    CBoardUI *m_pBoardUI;
};

#endif // TETRISUI_H
