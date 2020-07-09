<p align="center"><img src="./res/light_logo.png"></p>
<p align="center">
  <a href="https://github.com/thenaim/fit_app/releases" target="_blank">
    <img src="https://badgen.net/github/release/thenaim/fit_app">
  </a>
    <a href="https://github.com/thenaim/fit_app/commits/master">
    <img src="https://badgen.net/github/commits/thenaim/fit_app">
  </a>
    <a href="https://github.com/thenaim/fit_app/commits/master">
    <img src="https://badgen.net/github/last-commit/thenaim/fit_app">
  </a>
    </a>
    <a href="https://github.com/thenaim/fit_app/blob/master/LICENSE" target="_blank">
    <img src="https://badgen.net/github/license/thenaim/fit_app">
  </a>
</p>

## Main

Приложение для тех, кто ранее занимался в фитнес-клубе, а сейчас не хочет терять спортивную форму или работает над тем, как сбросить лишний вес. Идея в мотивации людей осваивать новые направления в спорте, не выходя из дома.

Это приложение - смесь игры и приложения для спорта и здоровья. В приложении есть цикл обучающих видео по разным типам занятий. Есть упражнения для всего тела, тренировки и разные виды рецептов для правильного питания.

Игровая составляющая приложения - на странице “Статистика” есть цветы (баллы и активность), которые игрок растит при просмотре обучающих видео, упражнение и различные виды тренировок. Существует leaderboard, где игроки могут посмотреть топ 5 пользователей приложения.

## Installation Guide

### Step 1. Install Emulator.

Documentation: [Emulator](https://devstingray.gs-labs.tv/emulator)

### Step 2. Clone App and install.

Clone fit_app to Emulator directory.

```bash
git clone https://github.com/thenaim/fit_app
./install_app ./fit_app
```

### Step 3. Install nodejs server

Clone fit_server to your home directory.
```bash
git clone https://github.com/thenaim/fit_server
cd fit_server
npm i
```
### Step 4. Run nodejs server

On [fit_server](https://github.com/thenaim/fit_server) project set your IPv4 and port on .evn file.

```bash
node app.js
```

### Step 5. Run Emulator.

On [fit_app](https://github.com/thenaim/fir_app) project set your IPv4 and port on js/app.js. In line 6.

```bash
./run_emu --audiocard-number=1 --audiodevice-number=0
```
## Stingray CLI tool for emulator :tada:
You can run apps, install, delete and update emulator.

For more information: [stingray-cli](https://github.com/thenaim/stingray-cli)

## Remote control functions :tada:
1. Add to bookmarks. This is the RED button on the remote.
2. A function to make it full screen. This is the GREEN button on the remote.
3. Change the design. This is the YELLOW button on the remote.

## Logo (created by me)

[Figma](https://www.figma.com/file/UxgnFWoQ5yJePKsSIgZ67l)

## License

License MIT (see the [LICENSE](https://github.com/thenaim/fit_app/blob/master/LICENSE) file for the full text)
