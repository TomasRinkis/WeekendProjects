//
//  CNSCoder.h
//  AppleCoder-OpenGLES-00
//
//  Created by Brolis on 7/15/14.
//
//

#ifndef __AppleCoder_OpenGLES_00__CNSCoder__
#define __AppleCoder_OpenGLES_00__CNSCoder__

#include"cNSObject.h"

//<std & stl
#include <map>

namespace custom
{
    /*goal is to save on file*/
    class CNSCoder : public CNSObject
    {
    public:
        //Constructor & destructor
        CNSCoder();
        virtual ~CNSCoder();
        
        //<api
        void encodeInt(const int &intv, const char *key);
        void encodeFloat(const float &floatv, const char *key);
        void encodeBool(const bool &boolv, const char *key);
        void encodeString(const char *string, const char *key);
        
        int decodeIntForKey(const char *key);
        float decodeFloatForKey(const char *key);
        bool decodeBoolForKey(const char *key);
        const char* decodeStringForKey(const char *key);
        
        //<file manipulation
        void saveOnDisk();
        void loadFromDisk();
        
        //<factory
        void initWithFileName(const char *fileName);
       static CNSCoder *create(const char *fileName);
    private://<state
        std::string m_strFileName;
        std::map<std::string, std::string> m_ValueMap;
    };
}

#endif /* defined(__AppleCoder_OpenGLES_00__CNSCoder__) */
