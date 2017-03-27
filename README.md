<img src="https://cloud.githubusercontent.com/assets/309224/21964712/bc5d538c-db51-11e6-9f29-347c64d649e2.png" alt="App Logo" width="60" height="60"> HolistiKit
======================================
[![Build Status](https://travis-ci.org/HolistiKit/HolistiKit.svg?branch=master)](https://travis-ci.org/HolistiKit/HolistiKit)
[![codecov](https://codecov.io/gh/HolistiKit/HolistiKit/branch/master/graph/badge.svg)](https://codecov.io/gh/HolistiKit/HolistiKit)

## About

HolistiKit is a framework which allows for holistic behavioral testing. This is achieved by injecting dependencies for things at the very ends of the object graph, and only those dependencies. This includes things like: date providing, network responses, user input/output, device orientation, and location. This approach allows for maximum decoupling between tests and implementation. If a feature hasn't changed from an outside persepective, the tests won't have to either.

