package main

import "core:fmt"

Node :: struct {
	data: int,
	next: ^Node,
}

print :: proc(node: ^Node) {
	head := node

	for {
		fmt.print(head.data)
		if head.next == nil do break
		fmt.print(", ")
		head = head.next
	}
	fmt.println()
}

end :: proc(node: ^Node) -> ^Node {
	head := node
	for {
		if head.next == nil {
			return head
		}
		head = head.next
	}
}

append :: proc(node: ^Node, n: int) {
	last := end(node)
	new_node := new(Node)
	new_node.data = n
	last.next = new_node
}

append_at :: proc(node: ^Node, position: int, data: int) {
	if position == 0 {
		// Make a copy of the first Node
		first := new(Node)
		first^ = node^

		node^ = new(Node)^
		node.data = data
		node.next = first
	}

	head := node
	for _ in 0 ..< position - 1 {
		head = head.next
		if head.next == nil {
			return
		}
	}

	link := head.next

	new_node := new(Node)
	new_node.data = data
	new_node.next = link

	head.next = new_node
}

delete_at_position :: proc(node: ^Node, position: int) {
	if position == 0 {
		node^ = node.next^
		return
	}

	head := node
	for _ in 0 ..< position - 1 {
		head = head.next
		if head.next == nil do return
	}

	to_delete := head.next
	link := to_delete.next

	head.next = link
	return
}

delete_by_value :: proc(node: ^Node, value: int) {
	if node.data == value {
		node^ = node.next^
		return
	}

	head := node
	for {
		next := head.next
		if next.data == value {
			head.next = next.next
			return
		}
		head = head.next
		if head.next == nil do return
	}
}

contains :: proc(node: ^Node, value: int) -> bool {
	if node.data == value {
		return true
	}
	head := node.next
	for {
		if head.data == value {
			return true
		}

		if head.next == nil {
			break
		}

		head = head.next
	}
	return false
}

main :: proc() {
	one := new(Node)
	two := new(Node)
	thr := new(Node)

	one.data = 1
	two.data = 2
	thr.data = 3

	one.next = two
	two.next = thr


	append(one, 24)
	print(one)
}
