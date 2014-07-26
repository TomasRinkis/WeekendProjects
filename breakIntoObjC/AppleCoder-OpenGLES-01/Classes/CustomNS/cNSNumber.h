//
//  NSNumber.h
//  AppleCoder-OpenGLES-00
//
//  Created by Brolis on 7/16/14.
//
//

#ifndef __AppleCoder_OpenGLES_00__NSNumber__
#define __AppleCoder_OpenGLES_00__NSNumber__

#include "cNSObject.h"

namespace custom
{
    typedef class CNSNumber* NSNumberPtr;
    
    class CNSNumber : public CNSObject
    {
    public:
        CNSNumber();
        virtual ~CNSNumber();
        
        int intValue(void);
        char charValue(void);
        bool boolValue(void);
        
        void initWithInt(const int &value);
        void initWithChar(const char &value);
        void initWithBool(const bool &value);
        
        //<creation
        static NSNumberPtr createWithInt(const int &value);
        static NSNumberPtr createWithChar(const char &value);
        static NSNumberPtr createWithBool(const bool &value);
        
    private: //<state
        void *data;
        
        void clearData();
    };
}

#endif /* defined(__AppleCoder_OpenGLES_00__NSNumber__) */
