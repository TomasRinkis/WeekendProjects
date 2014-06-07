#ifndef TETRISUI_H
#define TETRISUI_H

#include<QWidget>

//<Fowards
class QLCDNumber;
class QLabel;
class QPushButton;
class CTetrisBoardUI;

class CTetrisUI : public QWidget
{
    Q_OBJECT
public:

    //<Constructor & Destructor
    CTetrisUI();
    ~CTetrisUI();

private://<state
    QLCDNumber *m_pLCDLevel;
    QLCDNumber *m_pLCDScore;
    QLCDNumber *m_pLCDLines;

    QLabel  *m_pLBLLevel;
    QLabel  *m_pLBLScore;
    QLabel  *m_pLBLLines;

    QPushButton *m_pBtnMoveLeft;
    QPushButton *m_pBtnMoveRight;
    QPushButton *m_pBtnRotate;

    CTetrisBoardUI *m_pTetrisBoardUI;
};

#endif // TETRISUI_H
