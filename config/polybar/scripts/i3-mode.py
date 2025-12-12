#!/usr/bin/env python3
# criado por Hudson Albquerque (hud.and@yandex.com)
import subprocess
import json

try:
    # Obtém tree do i3
    result = subprocess.run(['i3-msg', '-t', 'get_tree'], 
                          capture_output=True, text=True)
    tree = json.loads(result.stdout)
    
    # Função para encontrar janela focada
    def find_focused(node):
        if node.get('focused'):
            return node
        for child in node.get('nodes', []) + node.get('floating_nodes', []):
            result = find_focused(child)
            if result:
                return result
        return None
    
    focused = find_focused(tree)
    
    if focused and focused.get('floating') in ['user_on', 'auto_on']:
        print("󰋒 FLOAT")
    else:
        print("󰙀 TILED")
except:
    print("󰙀")
