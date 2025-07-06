// フォロー処理
// フォローボタン
const buttons = document.querySelectorAll(".follow-toggle-button");

buttons.forEach((button) => {
  button.addEventListener("click", async () => {
    const userId = button.dataset.userId;
    const isFollowing = button.dataset.following === "true";
    const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute("content");

    // 同じユーザーIDを持つ全てのボタンを取得
    const targetButtons = document.querySelectorAll(`.follow-toggle-button[data-user-id="${userId}"]`);

    // 一括で仮の表示更新
    targetButtons.forEach((btn) => {
      updateFollowButtonVisual(targetButtons, !isFollowing); // 仮更新
    });

    try {
      let response;
      if (isFollowing) {
        // フォロー解除（DELETE）
        response = await fetch(`/api/follows/${userId}`, {
          method: "DELETE",
          headers: {
            "Content-Type": "application/json",
            "X-CSRF-Token": csrfToken
          }
        });
      } else {
        // フォロー（POST）
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

      // 成功時は何もしない（すでに表示は更新済み）

    } catch (error) {
      // エラー時、すべて元に戻す
      targetButtons.forEach((btn) => {
        updateFollowButtonVisual(targetButtons, !isFollowing); // 仮更新
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