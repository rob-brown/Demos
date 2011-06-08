#Demos

##GCD iPhone Sample
This is a simple example of how to use Grand Central Dispatch (GCD) in an iOS app. By removing the different calls to `dispatch_async`, and making other changes, you can see the affects on the app's performance. The random number generator is simply to see the affects of multithreading, or lack thereof, on the app's performance when performing concurrent operations. To demonstrate the need for multithreading, the app simulates a "big task" made up of many "smaller tasks" by putting its current thread to sleep during the smaller tasks.

##Quick Look
The Quick Look example shows how you might add the Quick Look framework to your app for file previewing. Check out my [`RBFilePreviewer` repo][1] for another potential way to add file previewing to your app.

##Quartz Composer
I have also included some of my random Quartz Composer projects. `RS Flip Flip` and `Toggle Switch` are patches that may be used as part of a larger Quarts composition. `Orbiting Spheres` and `Apple's Matrix` are originally intended to be used as screensavers. They, however, may be used in other ways as well.

##License

`Demos` is licensed under the MIT license, which is reproduced in its entirety here:

>Copyright (c) 2011 Robert Brown
>
>Permission is hereby granted, free of charge, to any person obtaining a copy
>of this software and associated documentation files (the "Software"), to deal
>in the Software without restriction, including without limitation the rights
>to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
>copies of the Software, and to permit persons to whom the Software is
>furnished to do so, subject to the following conditions:
>
>The above copyright notice and this permission notice shall be included in
>all copies or substantial portions of the Software.
>
>THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
>AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
>LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
>OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
>THE SOFTWARE.

  [1]: https://github.com/rob-brown/RBFilePreviewer
