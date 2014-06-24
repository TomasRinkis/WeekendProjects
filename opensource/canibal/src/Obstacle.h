//
//  Obstacle.h
//  CNBCanabaltGame
//
//  Copyright Semi Secret Software 2009-2010. All rights reserved.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//


@class CNBPlayer;

@interface Obstacle : FlxManagedSprite
{
  CNBPlayer * p;
}
+ (id) obstacleWithOrigin:(CGPoint)origin player:(CNBPlayer *)player;
+ (id) obstacleWithOrigin:(CGPoint)origin player:(CNBPlayer *)player alt:(BOOL)alt;
- (id) initWithOrigin:(CGPoint)origin player:(CNBPlayer *)player;
- (id) initWithOrigin:(CGPoint)origin player:(CNBPlayer *)player alt:(BOOL)alt;
@end
