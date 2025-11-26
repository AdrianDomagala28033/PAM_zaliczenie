# Wyszukiwarka darmowych gier

Aplikacja mobilna napisana w Flutterze, pozwalająca na wyszukiwanie darmowych gier, filtrowanie po platformie i gatunku, przeglądanie szczegółów gry oraz otwieranie linku do gry w przeglądarce. Aplikacja obsługuje tryb offline dzięki lokalnej persystencji danych, dzięki czemu lista gier jest dostępna również bez połączenia z internetem.

---

## Użyte API

Dane o grach pobierane są z API: [FreeToGame API](https://www.freetogame.com/api)

- Endpoint do listy gier: `https://www.freetogame.com/api/games`
- Endpoint do szczegółów gry: `https://www.freetogame.com/api/game?id=<gameId>`

---

## Funkcjonalności

- Lista darmowych gier z miniaturkami, tytułami i podstawowymi informacjami
- Wyszukiwanie gier po tytule
- Filtrowanie gier po platformie (PC / Browser) i gatunku
- Szczegóły gry: tytuł, miniatura, gatunek, platforma, krótki opis, wydawca, data wydania
- Przycisk „Graj teraz” przekierowujący na stronę gry w przeglądarce
- Obsługa trybu offline (dane lokalnie przetrzymywane)
- Ładny interfejs w ciemnym motywie z kolorystyką zielono-pomarańczową
- Obsługa błędów i braków danych (np. brak miniatury lub linku)

---

## Instrukcja uruchomienia

1. Sklonuj repozytorium:
   ```bash
   git clone <adres-repozytorium>
   cd <nazwa-folderu>
2. Zainstaluj zależność flutter:
    ```bash
   flutter pub get
3. Uruchom aplikację na wybranej platformie
   ```bash
   flutter run
4. Wspierane platformy
   android
   iOS
   Web
5. Prezentacja wideo załączona w zadaniu na teams