extends GutTest

const CHILD_COUNT: int = 7

var root: Node = Node.new()

func before_each() -> void:
	root.queue_free()
	root = Node.new()
	get_tree().root.add_child(root)
	for __ in CHILD_COUNT - 2:
		root.add_child(Node2D.new())
	root.add_child(Node3D.new())
	root.add_child(Node3D.new())


func test_unparent() -> void:
	var to_unparent: Node = root.get_children()[-1]
	autoqfree(to_unparent)
	UNode.unparent(to_unparent)
	assert_eq(root.get_child_count(), CHILD_COUNT - 1)
	

func test_clear_children() -> void:
	for child in root.get_children():
		autoqfree(child)
	UNode.clear_children(root)
	assert_eq(root.get_child_count(), 0)


func _is_2d(node: Node) -> bool:
	return node is Node2D
func test_clear_children_meeting() -> void:
	for child in root.get_children():
		if child is Node2D:
			autoqfree(child)
	UNode.clear_children_meeting(root, _is_2d)
	assert_eq(root.get_child_count(), 2)


func after_all() -> void:
	root.queue_free()
