//
//  NSRange.h
//  AppleCoder-OpenGLES-00
//
//  Created by Brolis on 7/16/14.
//
//

#ifndef __AppleCoder_OpenGLES_00__NSRange__
#define __AppleCoder_OpenGLES_00__NSRange__

namespace custom
{
    //<data junk
    typedef struct _NSRange
    {
        int location;
        int length;
    } NSRange;
    
    NSRange NSRangeMake(int loc, int len)
    {
        NSRange r;
        
        r.location = loc;
        r.length = len;
        
        return r;
    }
    
    bool NSLocationInRange(int loc, NSRange range)
    {
        return (loc >= range.location) && loc <= (range.location + range.length);
    }
}

#endif /* defined(__AppleCoder_OpenGLES_00__NSRange__) */
