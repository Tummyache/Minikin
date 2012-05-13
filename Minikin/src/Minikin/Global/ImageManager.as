package Minikin.Global 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Nick Heckman
	 */
	public class ImageManager extends Sprite
	{
		[Embed(source = "../Assets/MK_Hero.png")] public static const IMG_PLAYER:Class;
		[Embed(source = "../Assets/MK_Ground.png")] public static const IMG_GRASSY_GROUND:Class;
		[Embed(source = "../Assets/MK_Castle.png")] public static const IMG_CASTLE_GROUND:Class;
		[Embed(source = "../Assets/MK_Graveyard.png")] public static const IMG_GRAVEYARD_GROUND:Class;
		[Embed(source = "../Assets/MK_Desert.png")] public static const IMG_DESERT_GROUND:Class;
		[Embed(source = "../Assets/MK_Cave.png")] public static const IMG_CAVE_GROUND:Class;
		
		[Embed(source = "../Assets/MK_Dialog.png")] public static const IMG_DIALOG:Class;
		[Embed(source = "../Assets/MK_Cloud.png")] public static const IMG_CLOUD:Class;
		[Embed(source = "../Assets/MK_EmptyItem.png")] public static const IMG_EMPTY_CELL:Class;
		
		[Embed(source = "../Assets/MK_ParticleSmall.png")] public static const IMG_PARTICLE_SMALL:Class;
		
		// Swords
		[Embed(source = "../Assets/MK_Sword.png")] public static const IMG_SWORD:Class;
		[Embed(source = "../Assets/MK_SwordLong.png")] public static const IMG_SWORD_LONG:Class;
		[Embed(source = "../Assets/MK_SwordBig.png")] public static const IMG_SWORD_BIG:Class;
		[Embed(source = "../Assets/MK_SwordGiant.png")] public static const IMG_SWORD_GIANT:Class;
		[Embed(source = "../Assets/MK_SwordKaiser.png")] public static const IMG_SWORD_KAISER:Class;
		[Embed(source = "../Assets/MK_SwordAbsurd.png")] public static const IMG_SWORD_ABSURD:Class;
		
		[Embed(source = "../Assets/MK_Bubble.png")] public static const IMG_BUBBLE:Class;
		
		[Embed(source = "../Assets/MK_Wings.png")] public static const IMG_WINGS:Class;
		[Embed(source = "../Assets/MK_DefOrb.png")] public static const IMG_DEF_ORB:Class;
		[Embed(source = "../Assets/MK_HPOrb.png")] public static const IMG_HP_ORB:Class;
		[Embed(source = "../Assets/MK_AtkOrb.png")] public static const IMG_ATK_ORB:Class;
		
		// Backdrops
		[Embed(source = "../Assets/MK_ForestBack.png")] public static const IMG_BACK_FOREST:Class;
		[Embed(source = "../Assets/MK_CastleBack.png")] public static const IMG_BACK_CASTLE:Class;
		[Embed(source = "../Assets/MK_GraveyardBack.png")] public static const IMG_BACK_GRAVEYARD:Class;
		[Embed(source = "../Assets/MK_DesertBack.png")] public static const IMG_BACK_DESERT:Class;
		[Embed(source = "../Assets/MK_CaveBack.png")] public static const IMG_BACK_CAVE:Class;
		
		// NPCs
		[Embed(source = "../Assets/MK_King.png")] public static const IMG_KING:Class;
		[Embed(source = "../Assets/MK_Queen.png")] public static const IMG_QUEEN:Class;
		[Embed(source = "../Assets/MK_Jester.png")] public static const IMG_JESTER:Class;
		[Embed(source = "../Assets/MK_Skeleton.png")] public static const IMG_SKELETON:Class;
		[Embed(source = "../Assets/MK_SoothSayer.png")] public static const IMG_SOOTHSAYER:Class;
		
		// Effects
		[Embed(source = "../Assets/MK_DefUp.png")] public static const IMG_DEF_UP:Class;
		
		// Enemies
		[Embed(source = "../Assets/MK_Slime.png")] public static const IMG_SLIME:Class;
		[Embed(source = "../Assets/MK_SlimePink.png")] public static const IMG_SLIME_PINK:Class;
		[Embed(source = "../Assets/MK_SlimeBlue.png")] public static const IMG_SLIME_BLUE:Class;
		[Embed(source = "../Assets/MK_SlimeBoss.png")] public static const IMG_SLIME_BOSS:Class;
		[Embed(source = "../Assets/MK_Zombie.png")] public static const IMG_ZOMBIE:Class;
		[Embed(source = "../Assets/MK_Ghoul.png")] public static const IMG_GHOUL:Class;
		[Embed(source = "../Assets/MK_Whight.png")] public static const IMG_WHIGHT:Class;
		[Embed(source = "../Assets/MK_MagicMissile.png")] public static const IMG_MAGICMISSILE:Class;
		[Embed(source = "../Assets/MK_Bandit.png")] public static const IMG_BANDIT:Class;
		[Embed(source = "../Assets/MK_BanditKnifer.png")] public static const IMG_KNIFER:Class;
		[Embed(source = "../Assets/MK_BanditLeader.png")] public static const IMG_BANDITLEADER:Class;
		[Embed(source = "../Assets/MK_Knife.png")] public static const IMG_KNIFE:Class;
		[Embed(source = "../Assets/MK_HydraHead.png")] public static const IMG_HYRDAHEAD:Class;
		[Embed(source = "../Assets/MK_HydraNeck.png")] public static const IMG_HYRDANECK:Class;
		
		// Levels
		[Embed(source = "../Assets/Ogmo/Forest00.oel", mimeType = "application/octet-stream")] public static const LVL_FOREST00:Class;
		[Embed(source = "../Assets/Ogmo/Forest01.oel", mimeType = "application/octet-stream")] public static const LVL_FOREST01:Class;
		[Embed(source = "../Assets/Ogmo/Forest02.oel", mimeType = "application/octet-stream")] public static const LVL_FOREST02:Class;
		[Embed(source = "../Assets/Ogmo/Forest03.oel", mimeType = "application/octet-stream")] public static const LVL_FOREST03:Class;
		[Embed(source = "../Assets/Ogmo/Forest04.oel", mimeType = "application/octet-stream")] public static const LVL_FOREST04:Class;
		[Embed(source = "../Assets/Ogmo/Treetop00.oel", mimeType = "application/octet-stream")] public static const LVL_TREETOP00:Class;
		[Embed(source = "../Assets/Ogmo/Treetop01.oel", mimeType = "application/octet-stream")] public static const LVL_TREETOP01:Class;
		[Embed(source = "../Assets/Ogmo/Treetop02.oel", mimeType = "application/octet-stream")] public static const LVL_TREETOP02:Class;
		[Embed(source = "../Assets/Ogmo/Graveyard00.oel", mimeType = "application/octet-stream")] public static const LVL_GRAVEYARD00:Class;
		[Embed(source = "../Assets/Ogmo/Graveyard01.oel", mimeType = "application/octet-stream")] public static const LVL_GRAVEYARD01:Class;
		[Embed(source = "../Assets/Ogmo/Graveyard02.oel", mimeType = "application/octet-stream")] public static const LVL_GRAVEYARD02:Class;
		[Embed(source = "../Assets/Ogmo/GraveyardHole00.oel", mimeType = "application/octet-stream")] public static const LVL_GRAVEYARDHOLE00:Class;
		[Embed(source = "../Assets/Ogmo/GraveyardHole.oel", mimeType = "application/octet-stream")] public static const LVL_GRAVEYARDHOLE:Class;
		[Embed(source = "../Assets/Ogmo/Desert00.oel", mimeType = "application/octet-stream")] public static const LVL_DESERT00:Class;
		[Embed(source = "../Assets/Ogmo/Desert01.oel", mimeType = "application/octet-stream")] public static const LVL_DESERT01:Class;
		[Embed(source = "../Assets/Ogmo/Desert02.oel", mimeType = "application/octet-stream")] public static const LVL_DESERT02:Class;
		[Embed(source = "../Assets/Ogmo/Desert03.oel", mimeType = "application/octet-stream")] public static const LVL_DESERT03:Class;
		[Embed(source = "../Assets/Ogmo/Cave00.oel", mimeType = "application/octet-stream")] public static const LVL_CAVE00:Class;
		[Embed(source = "../Assets/Ogmo/Cave01.oel", mimeType = "application/octet-stream")] public static const LVL_CAVE01:Class;
		[Embed(source = "../Assets/Ogmo/Cave02.oel", mimeType = "application/octet-stream")] public static const LVL_CAVE02:Class;
		[Embed(source = "../Assets/Ogmo/Cave03.oel", mimeType = "application/octet-stream")] public static const LVL_CAVE03:Class;
		[Embed(source = "../Assets/Ogmo/Castle.oel", mimeType = "application/octet-stream")] public static const LVL_CASTLE:Class;
		
		// Music
		[Embed(source = "../Assets/Music/BossBaddy.mp3")] public static const SFX_BOSS:Class;
		[Embed(source = "../Assets/Music/FieldsOfDream.mp3")] public static const SFX_FOREST:Class;
		[Embed(source = "../Assets/Music/NothingsHereAtAll.mp3")] public static const SFX_GRAVEYARD:Class;
		[Embed(source = "../Assets/Music/DesertIGuess.mp3")] public static const SFX_DESERT:Class;
		[Embed(source = "../Assets/Music/Cahave.mp3")] public static const SFX_CAVE:Class;
		[Embed(source = "../Assets/Music/Title.mp3")] public static const SFX_TITLE:Class;
		
		// Sounds
		[Embed(source = "../Assets/Music/NPCTalk.mp3")] public static const SFX_NPC_TALK:Class;
		
		
		public function ImageManager() 
		{
		}
		
	}

}