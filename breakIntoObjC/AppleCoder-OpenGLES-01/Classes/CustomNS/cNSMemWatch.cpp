//
//  CNSMemWatch.cpp
//  AppleCoder-OpenGLES-00
//
//  Created by Brolis on 7/15/14.
//
//

#include "cNSMemWatch.h"

//<std & stl
#include<string>
#include<vector>

/*
 vector< string >::iterator it = curFiles.begin();
 
 while(it != curFiles.end()) {
 
 if(aConditionIsMet) {
 
 it = curFiles.erase(it);
 }
 else ++it;
 }
 */
namespace custom
{
    namespace
    {
        std::vector< CNSMemWatch::SLeakData> m_LeakDataArray;
        
        void addLeakData(const  CNSMemWatch::SLeakData &leakData)
        {
            
        }
        
        void removeLeakData(const  CNSMemWatch::SLeakData &leakData)
        {
            
        }
    }
    
    
    //<Constructor & Destructor
    CNSMemWatch::SLeakData::SLeakData()
    : m_strClassName("none")
    , m_uSize(0)
    {
        
    }
    
    static CNSMemWatch::SLeakData create(const char *className, const size_t &uSize)
    {
        CNSMemWatch::SLeakData leakData;
        leakData.setClassName(className);
        leakData.setSize(uSize);
        
        return leakData;
    }
    
    void CNSMemWatch::SLeakData::setClassName(const char *className)
    {
        m_strClassName = className;
    }
    
    const char *CNSMemWatch::SLeakData::className() const
    {
        return m_strClassName.c_str();
    }
    
    void CNSMemWatch::SLeakData::setSize(size_t size)
    {
        m_uSize = size;
    }
    
    std::size_t CNSMemWatch::SLeakData::size() const
    {
        return m_uSize;
    }
    
    
    
    //<constructor & destructor
    CNSMemWatch::CNSMemWatch()
    {
        m_leakData.setClassName("");
        m_leakData.setSize(sizeof(this));
    }
    
    CNSMemWatch::~CNSMemWatch()
    {
        
    }
    
    void *CNSMemWatch::operator new(std::size_t size)
    {
        return malloc(size);
    }
    
    void CNSMemWatch::operator delete(void *ptr)
    {
        free(ptr);
        ptr = nullptr;
    }
    
    void CNSMemWatch::dumpMemoryLeaks()
    {
        
    }
    
}