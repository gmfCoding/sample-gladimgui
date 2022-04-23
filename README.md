# About
**sample-glad-imgui-cmake** is my example project for getting **imgui**, **glad**, **glfw** with **cmake** to generate the buildfiles.

**Note**: I'm very unexperienced in this area so something could be improved but you are welcome to use this project at your own volition.

This project was mainly made so I could learn about **cmake**, **glad** and **imgui**.


# Building

I don't quite entirely understand how cmake works yet, I've been working on this with Windows 10 with **MSYS2 MinGW** installed so I've been using the **MinGW Makefiles** generators

1. Create a build directory (for cleanliness/organisation and easy cleaning)

    ```mkdir build;```

    ```cd build;```

2. Generate the MinGW Makefiles makefiles

    ```cmake -G "MinGW Makefiles" ../;```

3. Run the buildsystem to compile the program

    ```cmake --build .;```

# Building with G++

Just for the sake of the argument how would we go about building this with g++?

1. Create some folders

	`mkdir gpptmp;`

	`mkdir gppbin;`

	`mkdir lib;`

2. Download glfw3 binaries (or build them)
[glfw.org/download](https://www.glfw.org/download)

3. Grab the appropriate binaries and place them in our newly created lib directory (such as `\lib\glfw3dll.lib`)

4. Separatly compile glad

	`g++ -c app\vendor\glad\src\glad.c -o gpptmp\glad.o -Iapp\vendor\glad\include;`

5. Compile the main program
	`g++ app\src\*.cpp app\vendor\imgui\*.cpp app\vendor\imgui\backends\imgui_impl_opengl3.cpp app\vendor\imgui\backends\imgui_impl_glfw.cpp -o gppbin\main.exe gpptmp\glad.o app\srcinc -Iapp\vendor\include -Iapp\vendor\glad\include -Iapp\vendor\imgui -Iapp\vendor\imgui\backends -Iapp\vendor\glfw -Llib\ -DGLFW_INCLUDE_NONE -lglfw3 -std=c++17;`
6. Now we just have to place the `glfw3.dll` inside our `gppout` directory and the executable should be able to be executed!

What a mess! That's why we use a buildsystem so we don't have to deal with this mess everytime.
Adding new source files is a pain this way, but can be some what cleaned up (see [gpp_build.bat](/gpp_build.bat))

# VSCode
**WIP: (currently Windows Only, tasks.json need to be modified for other platforms)**


This project was designed to work both with VSCode and the command line.
In order to get keybinds working as wanted I had to create per project keybinds (which is generally not possible in vscode), but you can do it like so:

Define a config variable inside [settings.json](/.vscode/settings.json)
```json
"workspaceKeybindings.gmfcCMakeApp.enabled": true
```

And inside your keybindings.json (command pallet: `> Open Keyboard Shortcuts (JSON)`)
```json
// Place your key bindings in this file to override the defaults
[
      {
        "key": "ctrl+shift+f5",
        "command": "workbench.action.tasks.runTask",
        "args": "Build and Run Project",
        "when": "config.workspaceKeybindings.gmfcCMakeApp.enabled"
      },
	  // more custom keybinds ....
]
```

Even though this custom command will be defined globally for all vscode projects, it will not run when the project doesn't define `gmfcCMakeApp.enabled: true` inside it's [settings.json](/.vscode/settings.json).

I've decided the go with `"Build and Run Project"` as the standard name for a build and run task.

Which correlates to the [tasks.json](/.vscode/tasks.json)s' task for building and running the project.

[tasks.json](/.vscode/tasks.json) defines three tasks:

* Generate Cmake - Generate a make project with `MinGW Makefiles` inside  directory
* Build Cmake - Build, Link, and compile the project within the [build](/build) directory
* Run Project - Run the executable `app.exe` inside [build](/build) directory
* Build and Run Project - Run tasks: `Build Cmake` and `Run Project` in sequence.

That last tasks is the one that is assigned to the shortcut.

As for [launch.json](/.vscode/launch.json) there are 2 launch modes:
* Launch: Build and Debug program - Runs `Build Cmake` task and run gdb against the executable
* Launch: Build and Run Program - Run tasks: `Build and Run Project`