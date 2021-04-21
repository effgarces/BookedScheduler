<?php

require_once(ROOT_DIR . 'Domain/namespace.php');

class PermissionServiceTests extends TestBase
{
	public function testAsksStoreForAllowedResourcesAndReturnsTrueIfItExists()
	{
		$userId = 99;
		$user = new FakeUserSession();
		$user->UserId = $userId;

		$resource = new FakeBookableResource(1, 'whatever');
		$resourceIdList = array(3, 1, 4);

		$store = $this->createMock('IResourcePermissionStore');
		$ps = new PermissionService($store);

		$store->expects($this->once())
			->method('GetAllResources')
			->with($this->equalTo($userId))
			->will($this->returnValue($resourceIdList));

		$canAccess = $ps->CanAccessResource($resource, $user);

		$this->assertTrue($canAccess);
	}

	public function testCachesPermissionsPerUserForThisInstance()
	{
		$userId = 99;
		$user = new FakeUserSession();
		$user->UserId = $userId;

		$resource = new FakeBookableResource(1, 'whatever');
		$resourceIdList = array(3, 1, 4);

		$store = $this->createMock('IResourcePermissionStore');
		$ps = new PermissionService($store);

		$store->expects($this->once())
			->method('GetAllResources')
			->with($this->equalTo($userId))
			->will($this->returnValue($resourceIdList));

		$canAccess1 = $ps->CanAccessResource($resource, $user);
		$canAccess2 = $ps->CanAccessResource($resource, $user);

		$this->assertTrue($canAccess1);
		$this->assertTrue($canAccess2);
	}
}
?>
