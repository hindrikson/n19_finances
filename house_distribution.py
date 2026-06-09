gemeinschaftsraume = {
    "wohnzimmer": 39.7,
    "essbereich": 22.8,
    "kuche": 12.2,
    "sportraum": 27.3,
    "sauna_and_bad": 10.2,
    "bad": 6.5,
    "wc_unten": 1.2,
    "gaste_wc_oben": 0,
}

gemeinschaftliche_verkehrsflachen = {
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
}

lager_und_technik = {
    "waschraum": 9.3,
    "pumpenraum": 4.2,
    "heizol": 9.5,
    "heizungsraum": 5.7,
    "hausanschlussraum": 0.5,
    "lager": 4.0,
    "garage": 23.9,
}

ruda = {
    "zimmer": 15.0,
    "flur_vor_ruda": 2.2,
    "bad": 5.0,
}

arce = {
    "zimmer": 12.6,
    "ankleide": 1.9,
}

nona = {"zimmer": 17.5}

tanja = {"zimmer": 19.6}

viola = {"zimmer": 14.2}

lisa = {"zimmer": 6.9}

ronny = {"zimmer": 15.4}

einliegerwohnung = {
    "zimmer": 24.5,
    "kuche": 5.1,
    "flur": 3.5,
    "bad": 3.3,
    "kellerraum": 8.4,
}

totals = {
    "gemeinschaftsraume": sum(gemeinschaftsraume.values()),
    "gemeinschaftliche_verkehrsflachen": sum(
        gemeinschaftliche_verkehrsflachen.values()
    ),
    "lager_und_technik": sum(lager_und_technik.values()),
    "ruda": sum(ruda.values()),
    "arce": sum(arce.values()),
    "nona": sum(nona.values()),
    "tanja": sum(tanja.values()),
    "viola": sum(viola.values()),
    "lisa": sum(lisa.values()),
    "ronny": sum(ronny.values()),
    "einliegerwohnung": sum(einliegerwohnung.values()),
}

flache_total = sum(totals.values())

gewertete_flache = {
    "gemeinschaftsraume": totals["gemeinschaftsraume"] * 0.5,
    "gemeinschaftliche_verkehrsflachen": totals["gemeinschaftliche_verkehrsflachen"]
    * 0.25,
    "lager_und_technik": totals["lager_und_technik"] * 0.0,
    "ruda": totals["ruda"] * 1.1,
    "einliegerwohnung": (
        einliegerwohnung["zimmer"] * 1.1
        + einliegerwohnung["kuche"] * 1.1
        + einliegerwohnung["flur"] * 1.1
        + einliegerwohnung["bad"] * 1.1
        + einliegerwohnung["kellerraum"] * 0.0,
    ),
    "arce": totals["arce"] * 1.0,
    "nona": totals["nona"] * 1.0,
    "tanja": totals["tanja"] * 1.0,
    "viola": totals["viola"] * 1.0,
    "lisa": totals["lisa"] * 1.0,
    "ronny": totals["ronny"] * 1.0,
}
gewertete_flache_total = sum(gewertete_flache.values())

anteilungen_von_gewertete_flache = {
    "gemeinschaftsraume": gewertete_flache["gemeinschaftsraume"]
    / gewertete_flache_total,
    "gemeinschaftliche_verkehrsflachen": gewertete_flache[
        "gemeinschaftliche_verkehrsflachen"
    ]
    / gewertete_flache_total,
    "lager_und_technik": gewertete_flache["lager_und_technik"] / gewertete_flache_total,
    "ruda": gewertete_flache["ruda"] / gewertete_flache_total,
    "einliegerwohnung": gewertete_flache["einliegerwohnung"] / gewertete_flache_total,
    "arce": gewertete_flache["arce"] / gewertete_flache_total,
    "nona": gewertete_flache["nona"] / gewertete_flache_total,
    "tanja": gewertete_flache["tanja"] / gewertete_flache_total,
    "viola": gewertete_flache["viola"] / gewertete_flache_total,
    "lisa": gewertete_flache["lisa"] / gewertete_flache_total,
    "ronny": gewertete_flache["ronny"] / gewertete_flache_total,
}

kaltmieten = 33350.0

kaltmieten_anteilungen = {
    "gemeinschaftsraume": anteilungen_von_gewertete_flache["gemeinschaftsraume"]
    * kaltmieten,
    "gemeinschaftliche_verkehrsflachen": anteilungen_von_gewertete_flache[
        "gemeinschaftliche_verkehrsflachen"
    ]
    * kaltmieten,
    "lager_und_technik": anteilungen_von_gewertete_flache["lager_und_technik"]
    * kaltmieten,
    "ruda": anteilungen_von_gewertete_flache["ruda"] * kaltmieten,
    "einliegerwohnung": anteilungen_von_gewertete_flache["einliegerwohnung"]
    * kaltmieten,
    "arce": anteilungen_von_gewertete_flache["arce"] * kaltmieten,
    "nona": anteilungen_von_gewertete_flache["nona"] * kaltmieten,
    "tanja": anteilungen_von_gewertete_flache["tanja"] * kaltmieten,
    "viola": anteilungen_von_gewertete_flache["viola"] * kaltmieten,
    "lisa": anteilungen_von_gewertete_flache["lisa"] * kaltmieten,
    "ronny": anteilungen_von_gewertete_flache["ronny"] * kaltmieten,
}
