//
//  CNSAutoReleasePool.cpp
//  AppleCoder-OpenGLES-00
//
//  Created by Brolis on 7/15/14.
//
//

#include "cNSAutoReleasePool.h"

#define SAFE_DELETE(p) if(p) delete p; p = nullptr;

namespace custom
{
    namespace
    {
        static CNSAutoReleasePool *m_pAutoReleasePoolInstance = nullptr;
    }
    
    //<constructor & destructor
    CNSAutoReleasePool::CNSAutoReleasePool()
    {
    }
    
    CNSAutoReleasePool::~CNSAutoReleasePool()
    {
        destroy();
    }
    
    //<factory
    void CNSAutoReleasePool::init()
    {
        
    }
    
    //<object manipulation
    void CNSAutoReleasePool::purge()
    {
        for(iterator_t it = begin(); it != end(); ++it)
        {
            SAFE_DELETE(*(it));
        }
        m_ObjectArray.clear();
    }
    
    void CNSAutoReleasePool::refresh()
    {
        
    }

    //<gates
    void CNSAutoReleasePool::addObject(CNSObject *obj)
    {
    }
    
    void CNSAutoReleasePool::removeObject(CNSObject *obj)
    {
        
    }
    
    //<iterators
    CNSAutoReleasePool::iterator_t CNSAutoReleasePool::begin()
    {
        return m_ObjectArray.begin();
    }
    
    CNSAutoReleasePool::iterator_t CNSAutoReleasePool::end()
    {
        return m_ObjectArray.end();
    }
    
    //<singleton
    void CNSAutoReleasePool::create()
    {
        if(!m_pAutoReleasePoolInstance)
        {
            m_pAutoReleasePoolInstance = new CNSAutoReleasePool();
            m_pAutoReleasePoolInstance->init();
        }
    }
    
    
    void CNSAutoReleasePool::destroy()
    {
        if(m_pAutoReleasePoolInstance)
        {
            m_pAutoReleasePoolInstance->purge();
            SAFE_DELETE(m_pAutoReleasePoolInstance);
        }
    }
    
    
    CNSAutoReleasePool *CNSAutoReleasePool::sharedInstance()
    {
        create();
        return m_pAutoReleasePoolInstance;
    }
    
}
