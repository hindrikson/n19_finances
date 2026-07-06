# 1. Base Data Structure
IMMOBILIE = {
    "gemeinschaftsraume": {
        "wohnzimmer": 39.7,
        "essbereich": 22.8,
        "kuche": 12.2,
        "sportraum": 27.3,
        "sauna_and_bad": 10.2,
        "bad": 6.5,
        "wc_unten": 1.2,
        "gaste_wc_oben": 0,
    },
    "gemeinschaftliche_verkehrsflachen": {
        "entree": 6.1,
        "garderobe": 2.0,
        "treppe_wohnzimmer": 3.7,
        "flur_vor_garage": 4.0,
        "treppenhaus": 4.3,
        "flur_vor_waschraum": 3.5,
        "flur_vor_max_arce_und_anna": 11.6,
        "gem_kleiderschrank": 2.4,
        "terrasse_unten": 14.6,
        "flur_von_seba_und_ariane": 4.7,
    },
    "lager_und_technik": {
        "waschraum": 9.3,
        "pumpenraum": 4.2,
        "heizol": 9.5,
        "heizungsraum": 5.7,
        "hausanschlussraum": 0.5,
        "lager": 4.0,
        "garage": 23.9,
        "kellerraum": 8.4,  # Moved here
    },
    "ruda": {"zimmer": 15.0, "flur_vor_ruda": 2.2, "bad": 5.0},
    "arce": {"zimmer": 12.6, "ankleide": 1.9},
    "nona": {"zimmer": 17.5},
    "tanja": {"zimmer": 19.6},
    "viola": {"zimmer": 14.2},
    "lisa": {"zimmer": 6.9},
    "ronny": {"zimmer": 15.4},
    "einliegerwohnung": {
        "zimmer": 24.5,
        "kuche": 5.1,
        "flur": 3.5,
        "bad": 3.3,  # Kellerraum removed
    },
}

# 2. Weighting Factors Configuration
FACTORS = {
    "gemeinschaftsraume": 0.5,
    "gemeinschaftliche_verkehrsflachen": 0.25,
    "lager_und_technik": 0.0,
    "ruda": 1.1,
    "einliegerwohnung": 1.1,  # Added cleanly here
    "arce": 1.0,
    "nona": 1.0,
    "tanja": 1.0,
    "viola": 1.0,
    "lisa": 1.0,
    "ronny": 1.0,
}

KALTMIETEN = 3335.0

ANZAHL_PERSONEN = 8
ANZAHL_ZIMMER = 8

NEBENKOSTEN = {
    "gls_gebühr": 5,
    "wasser": 49,
    "heizöl": 400,
    "auflösungsbetrag": 80,
    "internet": 54.0,
    "gez": 55.08 / 4,
    "haushaltskasse": 80,
    "kontoführung": 3.8,
    "puffer": 80,
    "strom_haus": 200.00,
    "strom_einliegerwohnung": 31,
    # "miete_waschmaschine": 14.99, # drinnen im Puffer
}

# 3. Calculations
# Calculate absolute totals_immobilien per category
totals_immobilien = {
    category: sum(rooms.values()) for category, rooms in IMMOBILIE.items()
}
flache_total = sum(totals_immobilien.values())

gewertete_flache = {
    category: total_area * FACTORS[category]
    for category, total_area in totals_immobilien.items()
}
gewertete_flache_total = sum(gewertete_flache.values())

# Calculate percentage shares dynamically
anteilungen_von_gewertete_flache = {
    category: value / gewertete_flache_total
    for category, value in gewertete_flache.items()
}

# Calculate rent distribution
kaltmieten_anteilungen = {
    category: share * KALTMIETEN
    for category, share in anteilungen_von_gewertete_flache.items()
}


# 4. Output Results
print("Fläche pro Kategorie:")
for category, total in totals_immobilien.items():
    print(f"{category}: {total:.2f} m²")
print("\nGewichtete Fläche pro Kategorie:")
for category, weighted in gewertete_flache.items():
    print(f"{category}: {weighted:.2f} m²")
print("\nAnteilungen von gewichteter Fläche:")
for category, share in anteilungen_von_gewertete_flache.items():
    print(f"{category}: {share:.4f}")
print("\nKaltmietenanteil pro Kategorie:")
for category, rent in kaltmieten_anteilungen.items():
    print(f"{category}: {rent:.2f} EUR")
print("\nAnteilungen_von_gewertete_flache:")
for category, share in anteilungen_von_gewertete_flache.items():
    print(f"{category}: {share:.4f}")
