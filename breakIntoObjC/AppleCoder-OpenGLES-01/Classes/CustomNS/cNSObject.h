//
//  CSNObject.h
//  AppleCoder-OpenGLES-00
//
//  Created by Brolis on 7/15/14.
//
//

#ifndef __AppleCoder_OpenGLES_00__CSNObject__
#define __AppleCoder_OpenGLES_00__CSNObject__

#import "cNSMemWatch.h"

//<std & stl
#include <typeinfo>

namespace custom
{
    //<fowards
    class CNSObject;
    
    //<delegates
    typedef void (CNSObject::*Selector)();
    
    class CNSObject : public CNSMemWatch
    {
    public:
        //<constructor & destructor
        CNSObject();
        virtual ~CNSObject();
        
        virtual bool isEqual(CNSObject *object) const;
        
        //<Getters info
        virtual std::size_t hash() const;
        virtual const char *className() const;
        virtual const char *getDescription() const;
        virtual void dump();
        
        //ARC
        virtual void retain();
        virtual void release();
        virtual int referenceCounter() const;
        
        //<delegates
        virtual void setDelegateWithSelector(CNSObject *delegate, Selector selector);
        virtual void performDefaultDelegateSelector();
        
        //<factory
        virtual void init();
        static CNSObject *create();
        
    private: //<state
        int m_iReferenceCounter;
        
        CNSObject *m_pDelegate;
        Selector m_Selector;
    };
}

#endif /* defined(__AppleCoder_OpenGLES_00__CSNObject__) */
