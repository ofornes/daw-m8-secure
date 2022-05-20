# DAW - M8 - Pràctica de migració de webs

Per a la pràctica de com migrar les dades, s’ha optat per crear un exemple amb dues instal·lacions: la nova i la vella.

- La nova està muntada amb moodle-3.11 i postgresql-14.
- La vella està muntada amb els mateixos elements, però està nodrida amb configuració i dos cursos

A més, per a poder demostrar l’ús, s’han associat dos dominis públics per a poder accedir i comprovar la operativa:

| Moodle   | Domini                            | Observacions                                                 |
| -------- | --------------------------------- | ------------------------------------------------------------ |
| anterior | https://moodleant-daw8.fornes.cat | Està carregat amb dos cursos                                 |
| nou      | https://moodlenew-daw8.fornes.cat | Mostra pàgina d'avís de migració |

Al directori [assets/apache/sites-available](assets/apache/sites-available) hi ha dos arxius per a activar el proxy que permet _connectar_ els dominis amb els servidors dockers interns.

