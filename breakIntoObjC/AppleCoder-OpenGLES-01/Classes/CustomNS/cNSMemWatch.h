//
//  CNSMemWatch.h
//  AppleCoder-OpenGLES-00
//
//  Created by Brolis on 7/15/14.
//
//

#ifndef __AppleCoder_OpenGLES_00__CNSMemWatch__
#define __AppleCoder_OpenGLES_00__CNSMemWatch__

//std & stl
#include <iostream>

namespace custom
{
    
    //<fowards
    class CNSMemWatch
    {
    public:
        struct SLeakData
        {
        private:
            std::string m_strClassName;
            std::size_t m_uSize;
            
        public:
            //<Constructor & Destructor
            SLeakData();
            static SLeakData create(const char *className, const size_t &uSize);
            
            void setClassName(const char *className);
            const char *className() const;
            
            std::size_t size() const;
            void setSize(size_t size);
            
        } m_leakData;

    public:
        //<constructor & destructor
        CNSMemWatch();
        virtual ~CNSMemWatch();
        
        void *operator new(std::size_t size);
        void operator delete(void *ptr);
        
        virtual const char *className() const = 0;
        static void dumpMemoryLeaks();
    };
}

#endif /* defined(__AppleCoder_OpenGLES_00__CNSMemWatch__) */
