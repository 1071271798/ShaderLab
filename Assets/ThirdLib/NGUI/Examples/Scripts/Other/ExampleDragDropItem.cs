//----------------------------------------------
//            NGUI: Next-Gen UI kit
// Copyright © 2011-2014 Tasharen Entertainment
//----------------------------------------------

using UnityEngine;

[AddComponentMenu("NGUI/Examples/Drag and Drop Item (Example)")]
public class ExampleDragDropItem : UIDragDropItem
{
	/// <summary>
	/// Prefab object that will be instantiated on the DragDropSurface if it receives the OnDrop event.
	/// </summary>

	public GameObject prefab;

	/// <summary>
	/// Drop a 3D game object onto the surface.
	/// </summary>

	protected override void OnDragDropRelease (GameObject surface)
	{
		if (surface != null)
		{
			ExampleDragDropSurface dds = surface.GetComponent<ExampleDragDropSurface>();

			if (dds != null)
			{
				GameObject child = NGUITools.AddChild(dds.gameObject, prefab);
				child.transform.localScale = dds.transform.localScale;

				Transform trans = child.transform;
				trans.position = UICamera.lastWorldPosition;

				if (dds.rotatePlacedObject)
				{
					trans.rotation = Quaternion.LookRotation(UICamera.lastHit.normal) * Quaternion.Euler(90f, 0f, 0f);
				}
                Debug.Log("ios");
				// Destroy this icon as it's no longer needed
				NGUITools.Destroy(gameObject);
				return;
			}
		}
		base.OnDragDropRelease(surface);

  //      ControlManager.GetInstance().UpdateCurData(2);  // 如果有位置改变 则 更新数据
 //       ControlManager.GetInstance().UpdateCurData(3);
	}
}
