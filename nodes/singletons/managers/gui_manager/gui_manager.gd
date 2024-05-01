extends BaseGUIManager


@export var transitions_manager: TransitionsManager
@export var dialogue_gui_manager: DialogueGUIManager

@export var customize_character_screen: CustomizeCharacterScreen
@export var settings_menu: SettingsMenu
@export var quiz_attempt_screen: QuizAttemptScreen
@export var achievement_unlocked_screen: AchievementUnlockedScreen

@export var player_hud: PlayerHUD


func reset() -> void: 
	GUIManager.set_gui_active(quiz_attempt_screen, false)
	GUIManager.set_gui_active(player_hud, false)
	if AchievementUnlockedScreen.this() != null: 
		GameManager.set_gui_active(AchievementUnlockedScreen.this(), false)
	
