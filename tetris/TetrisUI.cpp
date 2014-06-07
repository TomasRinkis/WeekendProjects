#include"TetrisUI.h"
#include"TetrisBoardUI.h"

//<QT include
#include<QLCDNumber>
#include<QLabel>
#include<QPushButton>
#include<QGridLayout>


//<small factory
QLCDNumber *createLCDNumber(const uint &numDigits)
{
    QLCDNumber *pLCD = new QLCDNumber(numDigits);
    pLCD->setSegmentStyle(QLCDNumber::Filled);
    return pLCD;
}

QLabel *createLabel(const QString &text)
{
    QLabel *pLBL = new QLabel(text);
    return pLBL;
}

QPushButton *createPushButton(const QString &name)
{
    QPushButton *pPushButton = new QPushButton(name);\
    return pPushButton;
}


CTetrisUI::CTetrisUI()
{
    setWindowTitle(tr("Simple tetris game!"));

    //<create all instances
    m_pLCDLevel = createLCDNumber(5);
    m_pLCDScore = createLCDNumber(5);
    m_pLCDLines = createLCDNumber(5);

    m_pLBLLevel = createLabel("Level");
    m_pLBLScore = createLabel("Score");
    m_pLBLLines = createLabel("Lines");

    m_pBtnMoveLeft = createPushButton("Left");
    m_pBtnMoveRight = createPushButton("Right");
    m_pBtnRotate = createPushButton("Rotate");

    m_pTetrisBoardUI = CTetrisBoardUI::create();

    //Play with layout
    QGridLayout *pGridLayout = new QGridLayout;

    //<labels
    pGridLayout->addWidget(m_pLBLLevel, 0, 0);
    pGridLayout->addWidget(m_pLBLScore, 1, 0);
    pGridLayout->addWidget(m_pLBLLines, 2, 0);

    //<lcd
    pGridLayout->addWidget(m_pLCDLevel, 0, 1);
    pGridLayout->addWidget(m_pLCDScore, 1, 1);
    pGridLayout->addWidget(m_pLCDLines, 2, 1);

    //<buttons
    pGridLayout->addWidget(m_pBtnMoveLeft, 3, 0);
    pGridLayout->addWidget(m_pBtnMoveRight, 3, 2);
    pGridLayout->addWidget(m_pBtnRotate, 3, 1);

    //board
    pGridLayout->addWidget(m_pTetrisBoardUI, 0, 3, 8, 4);

    setLayout(pGridLayout);

    //<connect signals - slots

    //<TetrisUI -> TetrisBoardUI
    connect(m_pBtnMoveLeft, SIGNAL(clicked()), m_pTetrisBoardUI, SLOT(handleMoveLeftSignal()));
    connect(m_pBtnMoveRight, SIGNAL(clicked()), m_pTetrisBoardUI, SLOT(handleMoveRightSignal()));
    connect(m_pBtnRotate, SIGNAL(clicked()), m_pTetrisBoardUI, SLOT(handleRotateSignal()));

    connect(m_pTetrisBoardUI, SIGNAL(triggerLinesRemovedChange(int)), m_pLCDLines, SLOT(display(int)));

    resize(615, 422);
}

CTetrisUI::~CTetrisUI()
{

}
