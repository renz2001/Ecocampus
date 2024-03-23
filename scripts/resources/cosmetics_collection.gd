## This exists so that I can put all the cosmetics in a Resource without have to use a Global/Singleton to load all of the cosmetics
extends Resource
class_name CosmeticsCollection


@export var cosmetics: Array[Cosmetic]
