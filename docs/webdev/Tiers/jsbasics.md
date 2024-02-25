# **JavaScript**

<span class="green-command">
<span class="green-command">
<span class="green-command">

### <span class="webdev">Practical Concepts about OOP</span>
Yes you heard that right, its <span class="green-command">OOP(Object Oriented Programming)</span> and not `oops!`.

<span class="green-command">Example 1</span>: What is <span class="green-command">this</span>?  
Examine the below code carefully, when the private method `_onDown()` is called on an instance of `Cars` class, the event listener is not getting removed. Can you guess why?
``` javascript 
class Cars {
    constructor(engine, opts) {
        this._engine = engine;
        this._opts = opts;
    }

    init() {
        this._privateMethod();
    }

    #################### Private methods ##############################

    _privateMethod() {
        // Doing something that is only requierd by an instance of this class.
    }

    _bind() {
        certificate.register((e) => {
            if (!onClick)
                document.addEventListener('mousedown', this._onDown);

            if (onClick) {
                document.removeEventListener('mousedown', this._onDown);
            }
        });
    }

    _onDown() {
        console.log(this._onDown); // Prints 'undefined' in the console.
        document.removeEventListener('mousedown', this._onDown);
    }

    #################### Public methods ##############################
}
```

If `console.log(this._onDown)` returns `undefined`, it suggests that the `_onDown` function is not bound to the current object instance correctly, or it might not be defined in the context where you expect it to be.  
In JavaScript, the value of <span class="green-command">this</span> inside a function depends on how the function is called. If the function is called as a method of an object (e.g., object.method()), then <span class="green-command">this</span> refers to the object itself. Otherwise, in functions called without a context, <span class="green-command">this</span> typically refers to the global object (in non-strict mode) or undefined (in strict mode).

To ensure that `_onDown` is properly bound to the correct <span class="green-command">this</span>, you might need to use arrow functions or explicitly bind the function to a specific context.

<span class="green-command">Solution-A</span>  
You can explicitly bind the function to a specific context. In this example, _onDown is explicitly bound to the current object instance within the constructor function using the bind() method. This ensures that <span class="green-command">this</span> inside _onDown refers to the correct object instance.

``` javascript 
class Cars {
    constructor(engine, opts) {
        this._onDown = this._onDown.bind(this);
    }
}
```

<span class="green-command">Solution-B</span>  
Alternatively, you can use arrow functions. With arrow functions, <span class="green-command">this</span> lexically refers to the enclosing context, which means it retains the value of this from the surrounding code.

``` javascript 
class Cars {
    _onDown = () => {
        document.removeEventListener('mousedown', this._onDown);
    }
}
```

<span class="green-command">Example 2</span>: Objects in JavaScript  
This works but how is that possible?  
s[method] is s.setDev, if method = 'setDev'
so where is that <span class="green-command">.</span> coming from?

``` javascript
modules.forEach((m) => {
    if (m !== this._module) {
        let opts = { moduleType: value };
        let method = '';
        
        if (m.getType() === 'web') {
            method = 'setDev';
        } else if (m.getType() === 'security') {
            method = 'setMalware';
        }

        return s[method](opts);
    }
});
```

You're correct to question that. In JavaScript, when you use square brackets ([]) to access a property of an object, you can use a variable to specify the property name dynamically.  
For example, if you have an object `obj` and you want to access its property `prop`, you can use `obj[prop]`. If prop has a value of 'foo', then `obj[prop]` is equivalent to `obj.foo`.
In your case, `s[method]` is equivalent to `s['setDev']`, and because method is 'setDev', it resolves to `s.setDev`.  
This feature is often used for dynamic property access or dynamic method invocation in JavaScript. <span class="green-command">It's a powerful tool for writing flexible and concise code.</span>
