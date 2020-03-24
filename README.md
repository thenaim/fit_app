# FitSmart App

Home Fitness App for [StingrayTv]

## Installation

**Step 1.** Install NodeJs server [fit_server](https://github.com/thenaim/fit_server)
```sh
git clone https://github.com/thenaim/fit_server
```

**Step 2.** Install packages.
```sh
cd fit_server
```
```sh
npm install
```
**Step 3.** Install [StingrayTv Emulator]

Create new directory and install

Documentation [StingrayTv Emulator](https://devstingray.gs-labs.tv/emulator)

**Step 4.** Clone StingrayTv App

Clone app to [StingrayTv Emulator] directory

```sh
git clone https://github.com/thenaim/fit_app
```
**Step 5.** Install app to [StingrayTv Emulator]

```sh
./install_app ./fit_app
```
**Step 6.** Install IPv4 for server and app (for local work)

On Server project set IPv4 and port on `app.js` 15 line.

On App project [StingrayTv] set IPv4 and port on `js/app.js` on 5 line.

**Step 7.** Run server
```sh
cd fit_server
```
```sh
node app.js
```
Ps: If everything is ok, then you see like: `App is running at http://192.168.1.64:8080` 

**Step 8.** Run [StingrayTv Emulator]

Go to StingrayTv Emulator directory (where you install) and run command
```sh
./run_emu --audiocard-number=0 --audiodevice-number=1
```
`Warning!` If your have 2 or more audio cards in your host machine you must specify configured audio card and audio device manually in script arguments. From: [StingrayTv Emulator Docs](https://devstingray.gs-labs.tv/emulator)

**Step 9.** DONE!!

If you have any questions or app is not running, please let me know.

## Logo

[Logo](https://www.figma.com/file/UxgnFWoQ5yJePKsSIgZ67l)

Ps: Logo created by me)

## License

License MIT (see the [LICENSE](https://github.com/thenaim/fit_app/blob/master/LICENSE) file for the full text)
