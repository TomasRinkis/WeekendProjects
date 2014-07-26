//
//  CNSAutoReleasePool.h
//  AppleCoder-OpenGLES-00
//
//  Created by Brolis on 7/15/14.
//
//

#ifndef __AppleCoder_OpenGLES_00__CNSAutoReleasePool__
#define __AppleCoder_OpenGLES_00__CNSAutoReleasePool__

#include"cNSObject.h"

//<std & stl
#include<vector>

namespace custom
{
    class CNSAutoReleasePool : public CNSObject
    {
    public:
        typedef std::vector<CNSObject*>::iterator iterator_t;
        
    private:
     //<constructor & destructor
        CNSAutoReleasePool();
        virtual ~CNSAutoReleasePool();
        
    public:
        //<iterators
        iterator_t begin();
        iterator_t end();
        
        //<factory
        void init();
        
        //<object manipulation
        void purge();
        void refresh();
        
        //<gates
        void addObject(CNSObject *obj);
        void removeObject(CNSObject *obj);
        
        //<singleton
        static void create();
        static void destroy();
        
        static CNSAutoReleasePool *sharedInstance();
    private: //<state
        std::vector<CNSObject*> m_ObjectArray;
    };
}

#endif /* defined(__AppleCoder_OpenGLES_00__CNSAutoReleasePool__) */
