# 🗺️ Slashy Tresor



> Un système de chasse au trésor dynamique et immersif pour FiveM, offrant une expérience unique de découverte et de récompense.

## 🌟 Caractéristiques

- 🎯 Système de spawn dynamique des trésors
- 💰 Récompenses personnalisables (argent et items)
- 🗺️ Zones de spawn configurables avec coordonnées vec3
- 🔍 Système de recherche avec animations fluides
- 📢 Messages personnalisables
- ⚙️ Configuration complète et intuitive
- 🎮 Compatible avec tous les frameworks FiveM
- 🔒 Système anti-exploit intégré

## 🚀 Installation

1. Téléchargez la dernière version du script
2. Placez le dossier `Slashy_tresor` dans votre dossier `resources`
3. Ajoutez `ensure Slashy_tresor` dans votre `server.cfg`
4. Redémarrez votre serveur

## ⚙️ Configuration

Le script est entièrement configurable via le fichier `config.lua` :

```lua
Config.TreasureSpawnInterval = 30 -- Intervalle de spawn en secondes
Config.MaxTreasures = 3 -- Nombre maximum de trésors
Config.SearchRadius = 2.0 -- Rayon de recherche en mètres
```

### 💎 Récompenses

Personnalisez les récompenses selon vos besoins :

```lua
Config.Rewards = {
    money = {
        min = 1000,
        max = 5000
    },
    items = {
        {name = "weapon_pistol", chance = 10},
        {name = "goldbar", chance = 5},
        -- Ajoutez vos propres items ici
    }
}
```

### 🗺️ Zones de Spawn

Configurez facilement les zones de spawn avec des coordonnées vec3 :

```lua
Config.SpawnZones = {
    vec3(-1037.74, -2738.12, 20.17),
    vec3(1855.82, 3687.48, 34.27),
    -- Ajoutez vos propres zones ici
}
```

## 🎮 Utilisation

1. Les trésors apparaissent automatiquement dans les zones configurées
2. Les joueurs peuvent chercher des trésors en se rapprochant des zones
3. Une animation de recherche se déclenche
4. Si un trésor est trouvé, le joueur reçoit une récompense aléatoire

## 💡 Exemples d'Utilisation

- Créez des événements spéciaux de chasse au trésor
- Intégrez des récompenses uniques pour des événements saisonniers
- Utilisez comme système de récompense pour des missions
- Créez des zones de PvP autour des trésors

## 🤝 Support

- Pour toute question ou problème, n'hésitez pas à ouvrir une issue sur GitHub
- Rejoignez notre communauté Discord pour plus de support
- Consultez la documentation détaillée dans le wiki

## 📝 Licence

Ce projet est sous licence MIT. Voir le fichier `LICENSE` pour plus de détails.