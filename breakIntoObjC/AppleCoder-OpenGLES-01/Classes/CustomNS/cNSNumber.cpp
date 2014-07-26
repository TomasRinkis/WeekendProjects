//
//  NSNumber.cpp
//  AppleCoder-OpenGLES-00
//
//  Created by Brolis on 7/16/14.
//
//

#include "cNSNumber.h"

namespace custom
{
    CNSNumber::CNSNumber()
    : data(NULL)
    {
        
    }
    
    CNSNumber::~CNSNumber()
    {
        clearData();
    }
    
    void CNSNumber::clearData()
    {
        if(data)
        {
            free(data);
            data = NULL;
        }
    }
    
    int CNSNumber::intValue(void)
    {
        int value = reinterpret_cast<int>(data);
        return value;
    }
    
    char CNSNumber::charValue(void)
    {
        char value = (*(char*)(data));
        return value;
    }
    
    bool CNSNumber::boolValue(void)
    {
        bool value = (*(bool*)(data));
        return value;
    }
    
    void CNSNumber::initWithInt(const int &value)
    {
        clearData();
        
        data = malloc(sizeof(value));
    }
    
    void CNSNumber::initWithChar(const char &value)
    {
        clearData();

        data = malloc(sizeof(value));
    }
    
    void CNSNumber::initWithBool(const bool &value)
    {
        clearData();
        data = malloc(sizeof(value));
    }
    
    //<creation
    NSNumberPtr CNSNumber::createWithInt(const int &value)
    {
        NSNumberPtr pNum = new CNSNumber();
        pNum->initWithInt(value);
        
        return pNum;
    }
    
    
    NSNumberPtr CNSNumber::createWithChar(const char &value)
    {
        NSNumberPtr pNum = new CNSNumber();
        pNum->createWithChar(value);
        
        return pNum;
    }
    
    NSNumberPtr CNSNumber::createWithBool(const bool &value)
    {
        NSNumberPtr pNum = new CNSNumber();
        pNum->createWithBool(value);
        
        return pNum;
    }
}