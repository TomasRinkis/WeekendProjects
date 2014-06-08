#include"TBG_Window.h"
#include"TBG_BoardUI.h"

//<QT
#include<QGridLayout>

CWindow::CWindow()
{
    setWindowTitle(tr("turn based game!"));

    m_pBoardUI = new CBoardUI;

    //Play with layout
    QGridLayout *pGridLayout = new QGridLayout;

    //board
    pGridLayout->addWidget(m_pBoardUI, 0, 0, 8, 4);

    setLayout(pGridLayout);

    resize(615, 422);
}

CWindow::~CWindow()
{

}
