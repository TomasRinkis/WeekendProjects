//
//  CNSCoder.cpp
//  AppleCoder-OpenGLES-00
//
//  Created by Brolis on 7/15/14.
//
//

#include "cNSCoder.h"

namespace custom
{
    //Constructor & destructor
    CNSCoder::CNSCoder()
    : m_strFileName("")
    {
        
    }
    
    CNSCoder::~CNSCoder()
    {
        
    }
    
    //<api
    void CNSCoder::encodeInt(const int &intv, const char *key)
    {
        
    }
    
    void CNSCoder::encodeFloat(const float &floatv, const char *key)
    {
        
    }
    
    void CNSCoder::encodeBool(const bool &boolv, const char *key)
    {
        
    }
    
    void CNSCoder::encodeString(const char *string, const char *key)
    {
        m_ValueMap[key] = string;
    }
    
    int CNSCoder::decodeIntForKey(const char *key)
    {
        
    }
    
    float CNSCoder::decodeFloatForKey(const char *key)
    {
        
    }
    
    bool CNSCoder::decodeBoolForKey(const char *key)
    {
        
    }
    
    const char* CNSCoder::decodeStringForKey(const char *key)
    {
        return m_ValueMap[key].c_str();
    }
    
    //<file manipulation
    void CNSCoder::saveOnDisk()
    {
        
    }
    
    void CNSCoder::loadFromDisk()
    {
        
    }
    
    void CNSCoder::initWithFileName(const char *fileName)
    {
        CNSObject::init();
        m_strFileName = fileName;
    }
    
    CNSCoder *CNSCoder::create(const char *fileName)
    {
        CNSCoder *pNewCoder = new CNSCoder();
        pNewCoder->initWithFileName(fileName);
        
        return pNewCoder;
    }
}