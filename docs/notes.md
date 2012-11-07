# Routes

/ - index
braucht: arrays mit ids für geplante, live und gesendete episoden (index.slim)

/r/:id - (redirect) eine folge anzeigen, wenn nicht halt 404 (für shortlinks oder so)
-> redirect zu /shows/:show/:number wenn es geht

/shows/:show/:number - Eine Folge anzeigen
-> braucht: id der folge, titel der folge (für den header) (episode.slim)

/shows/:show - Archiv einer Show
braucht: show, show-title, arrays mit ids (geplant, live, published), meta-kram über die show (beschreibungstext z.b.) (show.slim)

## Pages

/pages/crew
braucht: ein array mit handles aller crew-mitglieder (crew.slim)

/pages/abo
braucht: irgendwie die ganzen feed-adressen

/pages/archive - generisches Archiv Template für queries nach Stichwort / Datum / etc.
braucht: array von ids, die es zu rendern gibt, infos über pagination, info über titel (was gesucht / angezeigt wird)

/pages/about, /pages/herpaderpa
 braucht: seiten-id, wird einfach aus einem generischen page.slim template generiert

/pages/calendar
 -> something something geplante folgen? vielleicht gleich mit dem archiv dingsen?


# Helper

## render_episode(id,mode)

modes: full, teaser, header, mini

full: rendert die ganze folge mit header, teaser, shownotes, allem
teaser: header + teaser und link zu den shownotes (wie auf dem index)
header: nur den header (für übersichtlichere Listen)
mini: Nur den Namen als Link zur Folge (für sehr basic listen, die geplanten folgen etc.)

full und teaser kann man im template super unterscheiden, die anderen beiden sollten direkt in code als templates aufgerufen werden

außerdem noch als local übergeben:
- mode auf jeden fall
- icon (aus dem status ablesen)
- status (damit ich so sachen machen kann wie den live link rausgeben etc.)
- title, tags, crew (array mit ids?), datum, id, number, show, show_title, etc. pp.
- getrennt: teasertext und shownotes...? oder so. oder da einen helper für?
- wenn die sendung geplant ist einen platzhalter-text anzeigen, der erklärt, wie das funktioniert

## render_shownotes(id)

gibt mit shownotes aus, schon durch markdown geparsed und durch alle amazon-sonstwas-filter geworfen

## render_description(id)

render description of episode (pass through markdown etc.pp.)

## render_host(handle, mode)

modes: full, name

full: siehe crew template
name: einfach nur einen link zur crew seite mit dem namen als titel

## render_feed_matrix()

exactly what it says on the tin... das muss ich noch überlegen.

# Fragen

- Wie wie regeln wir das Bootstrapping der flatfiles?
- Wie wird auf flatfiles geschrieben?
- Interne quque mittels sidekiq?
- Wie sieht unser Datenmodell aus?
