QT          += opengl widgets

HEADERS     = \
    TetrisUI.h \
    TetrisBoardUI.h \
    TetrisShape.h
SOURCES     = \
              main.cpp \
    TetrisUI.cpp \
    TetrisBoardUI.cpp \
    TetrisShape.cpp

# install
target.path = $$[QT_INSTALL_EXAMPLES]/opengl/2dpainting
INSTALLS += target
