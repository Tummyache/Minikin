package Minikin.Assets.Ogmo
{
public class LevelManager
{
[Embed(source="Castle.oel", mimeType = "application/octet-stream")] public static const LVL_CASTLE:Class;
[Embed(source="Cave00.oel", mimeType = "application/octet-stream")] public static const LVL_CAVE00:Class;
[Embed(source="Cave01.oel", mimeType = "application/octet-stream")] public static const LVL_CAVE01:Class;
[Embed(source="Cave02.oel", mimeType = "application/octet-stream")] public static const LVL_CAVE02:Class;
[Embed(source="Cave03.oel", mimeType = "application/octet-stream")] public static const LVL_CAVE03:Class;
[Embed(source="Desert00.oel", mimeType = "application/octet-stream")] public static const LVL_DESERT00:Class;
[Embed(source="Desert01.oel", mimeType = "application/octet-stream")] public static const LVL_DESERT01:Class;
[Embed(source="Desert02.oel", mimeType = "application/octet-stream")] public static const LVL_DESERT02:Class;
[Embed(source="Desert03.oel", mimeType = "application/octet-stream")] public static const LVL_DESERT03:Class;
[Embed(source="Forest00.oel", mimeType = "application/octet-stream")] public static const LVL_FOREST00:Class;
[Embed(source="Forest01.oel", mimeType = "application/octet-stream")] public static const LVL_FOREST01:Class;
[Embed(source="Forest02.oel", mimeType = "application/octet-stream")] public static const LVL_FOREST02:Class;
[Embed(source="Forest03.oel", mimeType = "application/octet-stream")] public static const LVL_FOREST03:Class;
[Embed(source="Forest04.oel", mimeType = "application/octet-stream")] public static const LVL_FOREST04:Class;
[Embed(source="Forest05.oel", mimeType = "application/octet-stream")] public static const LVL_FOREST05:Class;
[Embed(source="ForestBoss.oel", mimeType = "application/octet-stream")] public static const LVL_FORESTBOSS:Class;
[Embed(source="Graveyard00.oel", mimeType = "application/octet-stream")] public static const LVL_GRAVEYARD00:Class;
[Embed(source="Graveyard01.oel", mimeType = "application/octet-stream")] public static const LVL_GRAVEYARD01:Class;
[Embed(source="Graveyard02.oel", mimeType = "application/octet-stream")] public static const LVL_GRAVEYARD02:Class;
[Embed(source="GraveyardHole.oel", mimeType = "application/octet-stream")] public static const LVL_GRAVEYARDHOLE:Class;
[Embed(source="GraveyardHole00.oel", mimeType = "application/octet-stream")] public static const LVL_GRAVEYARDHOLE00:Class;
[Embed(source="GraveyardHole01.oel", mimeType = "application/octet-stream")] public static const LVL_GRAVEYARDHOLE01:Class;
[Embed(source="LevelManager.as", mimeType = "application/octet-stream")] public static const LVL_LEVELMANAGE:Class;
[Embed(source="Minikin.oep", mimeType = "application/octet-stream")] public static const LVL_MINIKIN:Class;
[Embed(source="Treetop00.oel", mimeType = "application/octet-stream")] public static const LVL_TREETOP00:Class;
[Embed(source="Treetop01.oel", mimeType = "application/octet-stream")] public static const LVL_TREETOP01:Class;
[Embed(source="Treetop02.oel", mimeType = "application/octet-stream")] public static const LVL_TREETOP02:Class;
public static function getLevel(name:String):Class {
if (name == "Castle") return LVL_CASTLE;
if (name == "Cave00") return LVL_CAVE00;
if (name == "Cave01") return LVL_CAVE01;
if (name == "Cave02") return LVL_CAVE02;
if (name == "Cave03") return LVL_CAVE03;
if (name == "Desert00") return LVL_DESERT00;
if (name == "Desert01") return LVL_DESERT01;
if (name == "Desert02") return LVL_DESERT02;
if (name == "Desert03") return LVL_DESERT03;
if (name == "Forest00") return LVL_FOREST00;
if (name == "Forest01") return LVL_FOREST01;
if (name == "Forest02") return LVL_FOREST02;
if (name == "Forest03") return LVL_FOREST03;
if (name == "Forest04") return LVL_FOREST04;
if (name == "Forest05") return LVL_FOREST05;
if (name == "ForestBoss") return LVL_FORESTBOSS;
if (name == "Graveyard00") return LVL_GRAVEYARD00;
if (name == "Graveyard01") return LVL_GRAVEYARD01;
if (name == "Graveyard02") return LVL_GRAVEYARD02;
if (name == "GraveyardHole") return LVL_GRAVEYARDHOLE;
if (name == "GraveyardHole00") return LVL_GRAVEYARDHOLE00;
if (name == "GraveyardHole01") return LVL_GRAVEYARDHOLE01;
if (name == "LevelManage") return LVL_LEVELMANAGE;
if (name == "Minikin") return LVL_MINIKIN;
if (name == "Treetop00") return LVL_TREETOP00;
if (name == "Treetop01") return LVL_TREETOP01;
if (name == "Treetop02") return LVL_TREETOP02;
return null;
}
}
}
