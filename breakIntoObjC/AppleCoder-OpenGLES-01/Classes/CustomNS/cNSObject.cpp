//
//  CSNObject.cpp
//  AppleCoder-OpenGLES-00
//
//  Created by Brolis on 7/15/14.
//
//

#include "cNSObject.h"
#include "cNSAutoReleasePool.h"

//<std & stl
#include <iostream>

namespace custom
{
    //<constructor & destructor
    CNSObject::CNSObject()
    : m_iReferenceCounter(0)
    , m_pDelegate(NULL)
    , m_Selector(NULL)
    {
    }
    
    CNSObject::~CNSObject()
    {
    }
    
    
    bool CNSObject::isEqual(CNSObject *object) const
    {
        return true;
    }
    
    
    //<Getters info
    std::size_t CNSObject::hash() const
    {
        return 1111111111;
    }
    
    const char *CNSObject::className() const
    {
        return  typeid(this).name();
    }
    
    const char *CNSObject::getDescription() const
    {
        return "CNSObject description";
    }
    
    void CNSObject::dump()
    {
        std::cout<<"Description: "<<getDescription()<<std::endl;
    }
    
    //ARC
    void CNSObject::retain()
    {
        ++m_iReferenceCounter;
        CNSAutoReleasePool::sharedInstance()->addObject(this);
    }
    
    void CNSObject::release()
    {
        --m_iReferenceCounter;
        CNSAutoReleasePool::sharedInstance()->refresh();
    }
    
    int CNSObject::referenceCounter() const
    {
        return m_iReferenceCounter;
    }
    
    //<delegates
    void CNSObject::setDelegateWithSelector(CNSObject *delegate, Selector selector)
    {
        m_pDelegate = delegate;
        m_Selector = selector;
    }
    
    void CNSObject::performDefaultDelegateSelector()
    {
        if(m_pDelegate && m_Selector)
        {
            (m_pDelegate->*m_Selector)();
        }
    }
    
    //<factory
    void CNSObject::init()
    {
        retain();
    }
    
    CNSObject *CNSObject::create()
    {
        CNSObject *pNewObject = new CNSObject();
        pNewObject->init();
        
        return pNewObject;
    }
}