const buttons = document.querySelectorAll(".follow-toggle-button");

buttons.forEach((button) => {
  button.addEventListener("click", async () => {
    const userId = button.dataset.userId;
    const isFollowing = button.dataset.following === "true";
    const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute("content");

    const targetButtons = document.querySelectorAll(`.follow-toggle-button[data-user-id="${userId}"]`);

    targetButtons.forEach((btn) => {
      updateFollowButtonVisual(targetButtons, !isFollowing);
    });

    try {
      let response;
      if (isFollowing) {
        response = await fetch(`/api/follows/${userId}`, {
          method: "DELETE",
          headers: {
            "Content-Type": "application/json",
            "X-CSRF-Token": csrfToken
          }
        });
      } else {
        response = await fetch("/api/follows", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            "X-CSRF-Token": csrfToken
          },
          body: JSON.stringify({ follow_user_id: userId })
        });
      }

      const result = await response.json();

      if (result.status !== "ok") {
        throw new Error(result.message || "サーバーエラーが発生しました");
      }

    } catch (error) {
      targetButtons.forEach((btn) => {
        updateFollowButtonVisual(targetButtons, !isFollowing);
      });
      alert(error.message || "通信エラーが発生しました");
      console.error(error);
    }
  });
});

function updateFollowButtonVisual(buttons, isFollowing) {
  buttons.forEach((btn) => {
    btn.textContent = isFollowing ? "フォロー中" : "フォロー";
    btn.dataset.following = isFollowing.toString();

    btn.classList.remove("btn-primary", "btn-light");
    btn.classList.add(isFollowing ? "btn-light" : "btn-primary");
  });
}