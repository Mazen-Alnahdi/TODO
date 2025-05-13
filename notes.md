entities is like a blueprint
repository is like contract

both cannot be tested

usecase can be tested and we have to test them before implement any functions

*Testing is crucial and part of the Test Driven Development*

https://github.com/Yczar/test-driven-dart/blob/master/test-driven-dart.pdf
for theory and revision side of the TDD for dart!


// What does the class depend on?
//Answer -- AuthenticationRepository
//How can we create a fake version of the dependency
//Answer --Use Mocktail
//How do we control with our dependencies
//Answer -- Using the Mocktail APIs


in test:

function [setUp] will be used so that each test will have fresh object from the class

function [setUpAll] is used when one object is used across multiple tests

when using the mock [usecase(param)], we need to control all the higher levels to get what we want.
therefore, we make a mock of the higher levels till we reach to the appropiate level that we are actually testing


function [any()] will place any value that the params requires

function[thenAnswer()] will force the function to return the success type

to replicate the void return, you write [(_) async => const Right(null)],
this will make the right side(success) and returns const null, with async

in the assert section:
when expection the Right, you write [Right<dynamic,void>(null)] thats if the right returns null
and if its left and it has something, you write [Left<void,dynamic>(null)]

meaning that you add dynamic to the opposite direction.

[verify.called(1)] means that it will be called once

[verifyNoMoreInteractions(repository)] ensure no redundant invocation occurs

https://www.dbestech.com/tutorials/flutter-test-with-mocktail
*more explanation on the mocktail*


