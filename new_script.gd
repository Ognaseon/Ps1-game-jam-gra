<<<<<<< HEAD


[ext_resource type="Script" uid="uid://caj1bs2q5nq0l" path="res://scenes/player.gd" id="1_o5qli"]
[ext_resource type="Script" uid="uid://dnb04daoumwie" path="res://scenes/enemy.gd" id="2_sugp2"]
[ext_resource type="Texture2D" uid="uid://c5tap4qx0ijyu" path="res://icon.svg" id="3_jyhfs"]
=======


[ext_resource type="Script" uid="uid://cyhvkmmb1oy1y" path="res://scripts/main.gd" id="1_0wfyh"]
[ext_resource type="PackedScene" uid="uid://bfidwqkr5lgj3" path="res://scenes/player.tscn" id="1_o5qli"]
>>>>>>> 675ea477010cdba86470a98f049e9be2da112b55

[sub_resource type="ProceduralSkyMaterial" id="ProceduralSkyMaterial_o5qli"]

[sub_resource type="Sky" id="Sky_0wfyh"]
sky_material = SubResource("ProceduralSkyMaterial_o5qli")

<<<<<<< HEAD
[sub_resource type="BoxShape3D" id="BoxShape3D_o5qli"]
size = Vector3(1, 1.271, 1)
=======
[sub_resource type="Environment" id="Environment_sugp2"]
background_mode = 2
sky = SubResource("Sky_0wfyh")
>>>>>>> 675ea477010cdba86470a98f049e9be2da112b55

[sub_resource type="PlaneMesh" id="PlaneMesh_0wfyh"]
size = Vector2(10, 10)

[sub_resource type="ConcavePolygonShape3D" id="ConcavePolygonShape3D_o5qli"]
data = PackedVector3Array(5, 0, 5, -5, 0, 5, 5, 0, -5, -5, 0, 5, -5, 0, -5, 5, 0, -5)

[sub_resource type="SphereShape3D" id="SphereShape3D_tbgi4"]

[node name="Main" type="Node3D"]
script = ExtResource("1_0wfyh")

<<<<<<< HEAD
[node name="floor" type="StaticBody3D" parent="."]

[node name="CSGBox3D" type="CSGBox3D" parent="floor"]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, -1.77014, -0.272217, 0.907227)
size = Vector3(21.3772, 0.455566, 15.707)
material = SubResource("StandardMaterial3D_o5qli")

[node name="CollisionShape3D" type="CollisionShape3D" parent="floor"]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, -3.33948, 0, 1.91827)
shape = SubResource("BoxShape3D_sgp6g")

[node name="player" type="CharacterBody3D" parent="."]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1.28394, 0)
script = ExtResource("1_o5qli")

[node name="CollisionShape3D" type="CollisionShape3D" parent="player"]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, -0.135498, 0)
shape = SubResource("BoxShape3D_o5qli")

[node name="CSGBox3D" type="CSGBox3D" parent="player"]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, -0.0230711, 0.0154344, -0.00688434)
size = Vector3(1, 1.12799, 1)
material = SubResource("StandardMaterial3D_0wfyh")

[node name="Camera3D" type="Camera3D" parent="player"]
transform = Transform3D(1, 0, 0, 0, 0.996677, -0.0814514, 0, 0.0814514, 0.996677, -0.0512218, 0.627215, -0.351282)
=======

[node name="DirectionalLight3D" type="DirectionalLight3D" parent="."]
transform = Transform3D(1, 0, 0, 0, 0.948512, 0.316742, 0, -0.316742, 0.948512, 0, 4.53876, -0.975449)
shadow_enabled = true

<<<<<<< HEAD
[node name="enemy" type="Area3D" parent="."]
script = ExtResource("2_sugp2")

[node name="Sprite3D" type="Sprite3D" parent="enemy"]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 2.61586, -6.34728)
texture = ExtResource("3_jyhfs")

[node name="CollisionShape3D" type="CollisionShape3D" parent="enemy"]
shape = SubResource("SphereShape3D_tbgi4")
=======
[node name="Player" parent="." instance=ExtResource("1_o5qli")]
transform = Transform3D(1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1.10594, -1.14622)
camera_sens = 3.0

[node name="floor" type="StaticBody3D" parent="."]

[node name="MeshInstance3D" type="MeshInstance3D" parent="floor"]
mesh = SubResource("PlaneMesh_0wfyh")

[node name="CollisionShape3D" type="CollisionShape3D" parent="floor"]
shape = SubResource("ConcavePolygonShape3D_o5qli")
>>>>>>> 675ea477010cdba86470a98f049e9be2da112b55
