# SpringExperiment

A little experiment framework defining a `Spring` type that implements basic
spring-ish physics. `Spring` is generic across `SpringArithmeticType`
(basically, anything float-like or float-like vectors) and is a `SequenceType`.

This makes it easy to wire up to a `CADisplayLink` or `CAKeyframeAnimation`.

## Eample

As a sequence:

```swift
let spring = Spring<Double>(from: 0, to: 1)
for state in spring {
    print(state.value)
}
```

See [BounceView][bounceview] in the demo app for an example using 
`CADisplayLink`.

## Caveats

This is just an experiment for now. Maybe someday it will turn into something 
like a Swifty-[Pop][pop] or `UIDynamics`? Or maybe it was a fun weekend project 
and will rot here. So, don’t expect to use this for much.

Also, currently `Spring` assumes that you achieve 60 FPS. So if you drop frames
you’re going to get incorrect physics. Oh, also I’m pretty sure the physics used
here are pretty … fuzzy. But it looks nice.


[bounceview]:https://github.com/bencochran/SpringExperiment/blob/master/BouncyDemo/BounceView.swift
[pop]:https://github.com/facebook/pop
