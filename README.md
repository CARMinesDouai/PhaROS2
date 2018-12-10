# PhaROS2
Pharo Client for ROS2
```
"Déclaration des noms"
nodeName := 'talker'.
namespace := '/namespace'.
topicName := 'topic'.

"Initialisation de la RCLC"
RCLC initNoArgs. 

"Création du noeud"
nodeTalker := RCLC createNode: nodeName namespace: namespace.

"Récupération du messageType"
msg := RCLC getMessageTypeSupport.


"Création du publisher"
pub := nodeTalker createPublisher: topicName queueSize: 10 messageType: msg.

"Destruction du noeud"
nodeTalker destroyMe.

"Ouverture d'inspecteur pour le débuggage"
nodeTalker inspect.
msg inspect.
```
