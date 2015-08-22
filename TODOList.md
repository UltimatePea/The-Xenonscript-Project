AT Monday, August 17, 2015 at 2:08PM

TODO:
<h4>
1. Get New MethodCall TVC Work
</h4>
<h4>
2. Seperate VC Codes form model
</h4>
<h4>
3. Build UI related APIs
</h4>
<h4>
4. Construct a Pure Object Orientied Framework mimicing Foundation, UIKit, and so on. Pure Object Oriented Framework means every method receives a parameter of kind Object (rewrite iOS APIs containing the use of such types as int, bool, double).
</h4>
Example:
<code>
@interface UIViewController

- (void)presentViewController:(UIViewController *)viewController animated:(BOOL)flag;
</code>
now will be modified to
<code>
@interface Boolean

@interace UIViewController

- (void)presentViewController:(UIViewController *)viewController animated:(Boolean *)flag;
</code>