# Kochess User Manual

Kochess is a simple yet functional chess application designed for your device. It allows you to play against a UCI chess engine (like Stockfish), load and save games in PGN format, and review past moves.

---

## Getting Started

### Launching Kochess

1.  From the **Main Menu** of your device, navigate to the **Tools** section.
2.  Select **"Chess Game"** to start Kochess.

Upon launching, a new game will begin automatically with the chess engine initialized. You will see the chessboard, PGN log, and status bars.

---

### Installation

To install Kochess, follow these steps:

1.    **Plugin installation:** Copy the Kochess plugin directory into your KOReader installation. The plugin directory name is `chess.koplugin`, so on most setups it will live at:

     * Generic: `koreader/plugins/chess.koplugin`
     * Kobo: `/mnt/onboard/.adds/koreader/plugins/chess.koplugin`
     * Kindle: `/mnt/us/koreader/plugins/chess.koplugin`

2.    **Icons:** Chess piece icons are bundled with the plugin under `chess.koplugin/icons/chess`. On first start, Kochess automatically copies them into KOReader's data icons directory (for example `.../koreader/icons/chess`) so that the UI can find them. Normally you do **not** need to copy icons manually.

3.    **Games:** Your saved game files (PGN) can be stored in any convenient location on your device.

4.    **Engine (optional):** To play against the computer, copy a UCI-compatible engine binary (for example Stockfish) into the plugin's `bin` folder and name it `stockfish`:

     * `koreader/plugins/chess.koplugin/bin/stockfish`

     Kochess will automatically try to start this engine on launch. If no working engine is present, you can still play Human vs Human and load/save games for analysis, but the **Robot** player options and engine settings will be hidden.

     The official repository of this plugin typically ships with a prebuilt `stockfish` binary already placed in `plugins/chess.koplugin/bin/stockfish`. That binary has been built and tested on Kobo Forma and Kindle Touch (both ARMv7). You are free to replace it with your own build if you want to tune performance or use a different Stockfish version.

---

## Interface Overview

The Kochess interface is designed for clarity and ease of use. It consists of the following main areas:

* **Title Bar (Top):** Displays the application title and general information or quick action buttons (like a menu button).
* **Chess Board (Middle):** This is where the chess pieces are displayed, and you interact with the game by tapping on squares to make moves.
* **PGN Log & Toolbar (Below Board):**
    * **PGN Log:** Shows the move history in Standard Algebraic Notation (SAN), along with game information and engine status.
    * **Toolbar:** Contains buttons for navigating through moves and managing game files.
* **Status Bar (Bottom):** Displays current game information, including player timers and who is currently playing (Human or Engine).

---

## Playing a Game

### Making a Move (Human Player)

Kochess supports touch-based move input:

1.  **Select a piece:** Tap on the piece you wish to move.
2.  **Select a destination:** Tap on the square where you want to move the piece.
3.  The move will be executed, the PGN log will update, and the turn will switch to the next player.

### Pawn Promotion

When a pawn reaches the last rank, a **promotion dialog** will appear, prompting you to choose the piece you wish to promote to (Queen, Rook, Bishop, or Knight). Select your desired piece to complete the move.

### Engine's Turn

When a player is configured as **Robot** and a working engine is available, Kochess automatically calculates and makes the engine's move when it is that side's turn. You can also force the engine to move immediately by hitting the `checkmark` button in the **Status Bar**.

### Game State

The **Status Bar** will show the current player's turn and remaining time:
* **⤆**: White's turn
* **⤇**: Black's turn
* **⤊**: Game is paused or in an initial/reset state.

When the game ends (checkmate or one of the draw conditions such as stalemate, insufficient material, threefold repetition, or the fifty-move rule), Kochess will stop the clocks and the engine, and show a **Game over** popup with the final result (for example `1-0`, `0-1`, or `1/2-1/2` and a short reason for draws).

---

## Game Controls & Features

### Timers

Kochess includes a game timer for both White and Black.
* The timers start counting down for the active player once the game begins (after the first human move or explicit request hitting the `checkmark` button).
* The current time for both players is displayed in the **Status Bar**.

### PGN Log

The **PGN Log** displays the game's moves.
* **Move History:** Shows the sequence of moves in Standard Algebraic Notation.
* **Headers:** Displays game information like Event, Date, White player, and Black player, if available from a loaded PGN.
* **Comments:** If there are comments associated with a move in the PGN, they will be shown.
* **Scrolling:** The log automatically scrolls to the most recent move.

### Toolbar Buttons

The toolbar, located next to the PGN log, provides several useful functions:

* **Undo Move (`chevron.left` icon):**
    * **Tap:** Undoes the last single move.
    * **Hold:** Undoes all moves, rewinding the game to the initial position.
* **Redo Move (`chevron.right` icon):**
    * **Tap:** Redoes the next available move in the history.
    * **Hold:** Redoes all available moves, replaying the game to the current end of the move history.
* **Save PGN (`bookmark` icon):** Opens a dialog to save the current game state as a PGN (Portable Game Notation) file.
    * You can choose the **folder** to save in.
    * You can enter a **filename**. The `.pgn` extension will be added automatically if not provided.
* **Load PGN (`appbar.filebrowser` icon):** Opens a file browser to load a PGN chess game from your device.
    * Select a `.pgn` file to load. The current game will be reset, and the loaded game will be displayed from its initial position.

---

## Settings

Kochess provides a settings dialog (accessed from the in-game menu) that allows you to configure how you want to play:

* **Player type:** Choose, separately for White and Black, whether the side is controlled by a **Human** or by the **Robot** engine. If the engine is not available or failed to start, these options are hidden and both sides are Human.
* **Engine strength:** When the engine exposes a `UCI_Elo` option (as Stockfish does), you can adjust the engine's approximate playing strength via an ELO slider.
* **Time controls:** Configure base time and increment (per move) independently for White and Black. These controls affect the timers shown in the Status Bar.

---

## Stockfish build notes

<details>
<summary>Build notes for the bundled Kobo/Kindle Stockfish binary</summary>

The `bin/stockfish` binary included with this plugin was built from a recent Stockfish release on an x86_64 Ubuntu system (WSL) using the Zig C++ compiler, targeting ARMv7 Linux so that it runs on both Kobo Forma and Kindle Touch.

To install Zig (example for x86_64 Linux/WSL), you can do something like:

```bash
cd ~
wget https://ziglang.org/builds/zig-x86_64-linux-0.16.0-dev.1484+d0ba6642b.tar.xz
tar xf zig-x86_64-linux-0.16.0-dev.1484+d0ba6642b.tar.xz
mkdir -p ~/bin
ln -s ~/zig-x86_64-linux-0.16.0-dev.1484+d0ba6642b/zig ~/bin/zig  # create ~/bin first if it does not exist
export PATH="$HOME/bin:$PATH"
```

Adjust the URL/version if a newer Zig release is available.

The exact commands to build Stockfish may vary depending on the Stockfish version you use, but the general idea is:

```bash
# Inside the Stockfish source tree (example path)
cd ~/Stockfish/src

make clean

# Example: build an ARMv7 binary with Zig C++ and NNUE embedding disabled
make build ARCH=general-32 \
  CXX="zig c++ -target arm-linux-musleabi" \
  CXXFLAGS_EXTRA="-march=armv7-a -marm -fno-exceptions -fno-rtti -Wno-error=date-time -DNNUE_EMBEDDING_OFF"

# After the build finishes, copy the resulting binary to the plugin:
cp stockfish /path/to/koreader/plugins/chess.koplugin/bin/stockfish
```

Please refer to the official Stockfish documentation for more exhaustive and up-to-date build instructions; the example above is only meant to document roughly how the bundled Kobo/Kindle binary was produced.

Note that on Android, external binaries placed under the KOReader data directory are typically on a filesystem mounted with `noexec`, so even a correctly built `stockfish` binary cannot be executed from there.
</details>

---

## License and Acknowledgement

All sources and creation are copyrighted by Baptiste Fouques and provided under the GPL license 3.0 or above.

The Chess game logic module is provided by arizati (https://github.com/arizati/chess.lua).

Icons are derived work from [Colin M.L. Burnett](https://en.wikipedia.org/wiki/User:Cburnett), provided under [GPLv2+](https://www.gnu.org/licenses/gpl-2.0.txt).

---

We hope you enjoy playing chess with Kochess! If you encounter any further issues or have suggestions, please open an issue so we can work on it.
