# New Coronavirus

Tieni comodamente traccia di tutti i dati nazionali sulla situazione Coronavirus. I dati nazionali, regionali e provinciali sono presi dalla repository della Protezione Civile.

## Built With

[Dart](https://dart.dev/ "Dart"): linguaggio di programmazione usato.

[Flutter](https://flutter.dev/ "Flutter"): framework open-source cross-platform.

[Redux](https://github.com/brianegan/flutter_redux "Flutter Redux"): libreria open source per la gestione dello state.

## Getting Started

Questo sono le istruzioni che dovrai seguire per poter installare l'app sui tuoi dispositivi o sui tuoi emulatori.

### Prerequisites

Prima di tutto bisogna avere flutter installato e lo si può fare tramite questa [guida](https://flutter.dev/docs/get-started/install "guida").

Il progetto è stato sviluppato con la versione **1.12.13+hotfix.8** sul channel **stable**.

Assicurati di avere un simulatore/emulatore o un dispositivo riconosciuto da Flutter. Utilizza questo comando per verificarlo:
```shell
 flutter devices
```

### Installing
#### Debug
Android e iOS
```shell
 flutter run
```
#### Release
Android
```shell
 flutter build apk --split-per-abi
```
Verranno creati due apk: uno per le architetture a 32-bit e un altro per quelle a 64-bit.

iOS
```shell
 flutter build ios
```

## Project Structure
### android/
File di build Android
### assets/
Immagini statiche utilizzate all'interno dell'app
### ios/
File di build iOS
### lib/
Contiene tutto il codice dell'app
- **api/**
    - Logica relativa alle chiamate di rete
    - Comunicazione con le API

- **components/**
    - Componenti globali utilizzati in varie parti dell'app

- **network/**
    - Chiamate di rete per ogni pagina che ne necessità

- **redux/**
    - **actions/**
      - Tipi di azioni utili per la modifica dello state
    - **reducers/**
      - Reducer per lo store di Redux
    - **store/**
      - Stato iniziale dello store

- **lib/**
     - Ogni schermata ha il proprio file di entry point.
	   - **components/**
	     - Sottocomponenti utilizzati unicamente in quella specifica schermata

- **utils/**
	- Classi e file utilizzati in tutta l'app

- **main.dart**
	- Entry point dell'app
